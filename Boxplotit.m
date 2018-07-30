function Boxplotit(measured)
    close all;
    
    fig = figure;
    hold on;
    ylabel('Time in seconds');
    boxplot(measured,{'MT','AT'});
    
    figsave(fig,'C:\Users\sahar\Desktop\matlab_figure_boxplot.pdf');
    
end
