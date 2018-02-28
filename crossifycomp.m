function mat=crossifycomp(data)

% mat=crossifycomp(Realdata) % Kolla mve och mte för degree i [1,2,3,4] med
% 10,100 och 1000 interationer. Första två kolumner ut är för polynom,
% sista två kolumner för spline. Kolumner är, PMVE,PMTE,SMVE,SMTE. Första
% fyra raderna är för 10 iterationer, nästa fyra för 100 och sista fyra för
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
