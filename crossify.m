function [valmeandeviation,trainmeandeviation]=crossify(data,k,degree,doplot,iterations,polyorspline)
% Example run from command window:
% >> crossify(Realdata,5,3,true,1)   % plot over fits for _one_ partition
% >> crossify(Realdata,5,3,true,100) % returns average mean square
% deviation over 100 different partitions, no plot.
% partitions
% iterations must be 1 to show plots.
% polyorspline=true: polynomial fit
% polyorspline=false: spline fit

if nargin<6
    polyorspline=true;
end

if ~polyorspline
    degree=degree+1;
end

RMSDSUM=0;
RMSDTRAINSUM=0;

valmeandeviation= zeros(iterations, 1);
trainmeandeviation=zeros(iterations, 1);


% if(iterations~=1)
%     doplot=false;
% end
        miny=min(data(:,2));
        maxy=max(data(:,2));
        minx=min(data(:,1));
        maxx=max(data(:,1));
        plotx=minx:(maxx-minx)/500:maxx; % plot continous polynomials
       % plotx=data(:,1); % plot line-interpolated polynomials

for(iter=1:iterations)
    RMSDSUM=0;
    RMSDTRAINSUM=0;

     if(doplot)
         fig=figure('Name',strcat('Cross validation k=',num2str(k),' d=',num2str(degree)));
        hold on;
     end
    part=crossvalind('Kfold',size(data,1),k);
    for valpart=1:k
        val=data(part==valpart,:);
        train=data(part~=valpart,:);
        
        if polyorspline
            poly=polyfit(train(:,1),train(:,2),degree);
            predval=polyval(poly,val(:,1));
            predtrain=polyval(poly,train(:,1));
        else
            spline=splinefit(train(:,1),train(:,2),8,degree);
            predval=ppval(spline,val(:,1));
            predtrain=ppval(spline,train(:,1));
        end
        
        eval=predval-val(:,2);
        RMSD=(sqrt(eval'*eval/size(val,1)));
        RMSDSUM=RMSDSUM+RMSD;
        
        etrain=predtrain-train(:,2);
        RMSDtrain=(sqrt(etrain'*etrain/size(train,1)));
        RMSDTRAINSUM=RMSDTRAINSUM+RMSDtrain;
        
        if(doplot)
            if polyorspline
                plot(plotx,polyval(poly,plotx),'Linewidth',2);
            else
                plot(plotx,ppval(spline,plotx),'Linewidth',2);
            end
        end
    end

    if(doplot)
        plot(data(:,1),data(:,2),'o');

        axis([minx,maxx,miny,maxy]);
        xlabel('Maximum time');
        ylabel('Actual time');
        legend('k=1','k=2','k=3','k=4','k=5');
    end
    valmeandeviation(iter)=RMSDSUM/k;
    trainmeandeviation(iter)=RMSDTRAINSUM/k;
end

end
