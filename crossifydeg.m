function [mve,mte]=crossifydeg(data,k,degrees,doplot,iterations,polyorspline,imagefilename)
    close all;
    % degrees is a vector of the polynomial degrees to test the data on
    % >> crossifydeg(database,5,1:4,true,100)
    %    plot validation and training errors for polynomials models
    %    of degree 1 to 4, with average values over 100 different
    %    partitions.
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % WITH POLYNOMIAL:
    % crossifydeg(Realdata,5,1:5,true,100,true,'C:\Users\sahar\Desktop\matlab_figure.pdf')
    % WITH SPLINE:
    % crossifydeg(Realdata,5,1:4,true,1000,false,'C:\Users\sahar\Desktop\matlab_figure.pdf')
    
    twoplots=false;
    pathplots=true;
    
    
    if nargin<6
        polyorspline=true;
    end
    if nargin<7
        imagefilename='C:\Users\sahar\Desktop\matlab_figure.pdf';
    end
    
    
%     rmsd=[];
%     rmsd = zeros(iterations, length(degrees));
%    degree = zeros(iterations, length(degrees));
    devv = zeros(iterations, length(degrees));
    devt = zeros(iterations, length(degrees));
    for(degree=degrees)
        ix = find(degree==degrees);
        [devv(:, ix),devt(:, ix)]=crossify(data,k,degree,false,iterations,polyorspline);
%        rmsd=[rmsd;degree,devv,devt];
    end
    
%     disp(rmsd);
    
%     if(doplot & twoplots)
%         fig=figure('Name',strcat('Cross validation k=',num2str(k),' d=',num2str(degrees(1)),'...',num2str(degrees(numel(degrees)))));
%         subplot(2,1,1)
%         hold on;
%         plot(degrees,devv','.-','Linewidth',0.3);
%         plot(degrees,mean(devv', 2), 'k', 'Linewidth',4);
%         
%         subplot(2,1,2)
%         hold on;
%         plot(degrees,devt','.-','Linewidth',0.3);
%         plot(degrees,mean(devt', 2), 'k', 'Linewidth',4);
% %         plot(rmsd(:,1),rmsd(:,2),'Linewidth',2);
% %         plot(rmsd(:,1),rmsd(:,3),'Linewidth',2);
%     end
    
    if(doplot & ~twoplots)
        
        fig=figure('Name',strcat('Cross validation k=',num2str(k),' d=',num2str(degrees(1)),'...',num2str(degrees(numel(degrees)))));
        hold on;
        xticks(degrees);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TODO ADJUST
        yticks(1:0.5:10);
        axis( [min(degrees),max(degrees),1,3] ); % change y-axis span, [1,3] now.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ^^^
        
        
        grid on;
        set(gcf,'units','points','position',[0,0,500,350])
        legend('Location','northeast');
        
        if pathplots
            ve=plot(degrees,devv',':','Linewidth',1,'Color',[0.3,0.3,1,1]);
        end
        
        mve=plot(degrees,mean(devv', 2), 'k', 'Linewidth',4,'Color','g');
        mte=plot(degrees,mean(devt', 2), 'k', 'Linewidth',4,'Color','r');
        
        if pathplots
           te=plot(degrees,devt','+','Linewidth',6,'Color',[0,0,0,1]);
        end
        
%         plot(rmsd(:,1),rmsd(:,2),'Linewidth',2);
%         plot(rmsd(:,1),rmsd(:,3),'Linewidth',2);
    end
    
    if(doplot)
        if polyorspline
            xlabel('Polynomial Degree');
        else
            xlabel('Spline Degree');
        end
        ylabel('Root mean square error')
       % legend('Cross-validation error','Mean cross-validation error','Training error','Mean training error');
       if pathplots
            legend([ve(1),te(1),mve,mte],{'Validation errors','Training errors','Mean validation error','Mean training error'});
       else
          legend([mve,mte],{'Mean validation error','Mean training error'});
       end
    end
   
   if polyorspline
       disp( ['POLY from degree ',num2str(min(degrees)),' to ',num2str(max(degrees)),' in ',num2str(iterations),' iterations.'] );
   else
       disp( ['SPLINE from order ',num2str(min(degrees)),' to ',num2str(max(degrees)),' in ',num2str(iterations),' iterations.'] );
   end
   
   disp 'Mean validation error'
   mve=mean(devv, 1)
   
   disp 'Mean training error'
   mte=mean(devt, 1)
   
   if(doplot)
        figsave(fig,imagefilename);
   end
   
end
