function mat=crossifycomp(data)

% mat=crossifycomp(Realdata) % Kolla mve och mte f�r degree i [1,2,3,4] med
% 10,100 och 1000 interationer. F�rsta tv� kolumner ut �r f�r polynom,
% sista tv� kolumner f�r spline. Kolumner �r, PMVE,PMTE,SMVE,SMTE. F�rsta
% fyra raderna �r f�r 10 iterationer, n�sta fyra f�r 100 och sista fyra f�r
% 1000.
iters=[10,100,1000];

pmve=[];
pmte=[];
smve=[];
smte=[];

for(iter=iters)
    
    if(iter==1000)
        doplot=true;
    else
        doplot=false;
    end
    
    % polynomial mve and mte

    [v,t]=crossifydeg(data,5,1:4,doplot,iter,true,'C:\Users\sahar\Desktop\matlab_figure_pol.pdf');
    pmve=[pmve;v'];
    pmte=[pmte;t'];
    
    % spline mve and mte
    [v,t]=crossifydeg(data,5,1:4,doplot,iter,false,'C:\Users\sahar\Desktop\matlab_figure_spline.pdf');
    smve=[smve;v'];
    smte=[smte;t'];
end

%format bank;
mat=[pmve,pmte,smve,smte]


end
