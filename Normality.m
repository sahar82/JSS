function res=Normality(measured,degreespoly,degreesspline)

    % Normality(Realdata,[1,2,3,4],[1,2,3,4]);
    % NOTE: id degreespoly or degreesspline changes :: ADJUST LEGENDS

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SPLINE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fig=figure();
    xlim([-5,5]);
    hold on;
    
    meansum=0;
    varsum=0;
    
    for(degree=degreesspline)
        spline=splinefit(measured(:,1),measured(:,2),8,degree);
        val=ppval(spline,measured(:,1));
        
        residuals = val-measured(:,2)
        
        meansum=meansum+mean(residuals);
        varsum=varsum+var(residuals);
        
        [normality,p] = kstest(residuals);
        
        [EAT,EMT]= ecdf(residuals);
        
        plot(EMT,EAT,'LineWidth',1.3);
        
        disp(normality);
        disp(p);
    end
 
    x_values = -10:0.01:10;
    G = plot(x_values,normcdf(x_values,0,1.4),'k','LineWidth',1.5);
    disp('....');
    disp(meansum);
    disp(varsum/4);

    legend('Linear ECDF','Quadratic ECDF','Cubic ECDF','4th degree ECDF','Normal CDF');
    legend('Location','northwest');
    figsave(fig,'C:\Users\sahar\Desktop\matlab_figure_normality_spline.pdf');

    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % POLY
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fig=figure();
    xlim([-5,5]);
    hold on;
    
    meansum=0;
    varsum=0;
    
    for(degree=degreespoly)
        poly=polyfit(measured(:,1),measured(:,2),degree);
        val=polyval(poly,measured(:,1));
        
        residuals = val-measured(:,2)
        
        meansum=meansum+mean(residuals);
        varsum=varsum+var(residuals);
        
        [normality,p] = kstest(residuals);
        
        [EAT,EMT]= ecdf(residuals);
        
        plot(EMT,EAT,'LineWidth',1.3);
        
        disp(normality);
        disp(p);
    end
 
    x_values = -10:0.01:10;
    G = plot(x_values,normcdf(x_values,0,1.4),'k','LineWidth',1.5);
    disp('....');
    disp(meansum);
    disp(varsum/4);

    legend('Linear ECDF','Quadratic ECDF','Cubic ECDF','4th degree ECDF','Normal CDF');
    legend('Location','northwest');
    figsave(fig,'C:\Users\sahar\Desktop\matlab_figure_normality_poly.pdf');
    
    
   
end
