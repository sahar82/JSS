function generate_statistics=generate_statistic(measured,degreespoly,degreesspline)
    % USAGE: measured is n x 2 matrix with independent variable in first
    %   column and dependent variable in second column.
    %   degreespoly   = [[e.g.]] = [1,2,3,4] selects polynomial degrees 1,2,3,4
    %   degreesspline = [[e.g.]] = [1,2,3,4] selects spline degrees 0,1,2,3
    % EXAMPLE: generate_statistics(Realdata,[1,2,3,4],[1,2,3,4]);
    
    %FITS=[];

    PTABLE=[];
    
    col=1;
    
    disp("Polynomial coefficients. Highest degree coeff first.");
    for(degree=degreespoly)
        poly=polyfit(measured(:,1),measured(:,2),degree);
        val=polyval(poly,measured(:,1));
        
        %disp(["deg",degree,"coeff",poly]);
        
        PTABLE(1,col)=rsquared(measured,val);
        for(c=1:degree+1)
            PTABLE(c+1,col)=poly(degree+2-c);
        end
        col=col+1;
        
        %FITS=[FITS,val];
    end
    
    
    for(degree=degreesspline)
        spline=splinefit(measured(:,1),measured(:,2),8,degree);
        val=ppval(spline,measured(:,1));
        
        PTABLE(1,col)=rsquared(measured,val);
        col=col+1;
        
        %FITS=[FITS,val];
        %disp(spline);
    end
    
    rownames={'R squared'};
    colnames={};
    for(i=2:max(degreespoly)+2)
        rownames=[rownames,strcat('c',num2str(i-2))];
    end
    
    for(i=1:size(degreespoly,2))
        colnames=[colnames,strcat('Poldegree',num2str(degreespoly(i)))];
    end
    
    for(i=size(degreespoly,2)+1:size(degreespoly,2)+size(degreesspline,2))
        colnames=[colnames,strcat('Spldegree',num2str(degreesspline(i-size(degreespoly,2))))];
    end
    
    %PTABLE
    array2table(PTABLE,'RowNames',rownames,'VariableNames',colnames)
    
    %generate_statistics= rsquared(measured,FITS);
end
