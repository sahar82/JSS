function crossifyDOIT(data)
    % RUNS cross validation fitting on data, and plots fits.
    % TODO: For new data change y-axis for plots in files:
    % crossifyplotfits.m
    % and
    % crossifycomp.m
    % SEE SEARCH STRING "TODO ADJUST" IN THESE FILES!!


    % PLOT POLYNOMIAL AND SPLINE FITS FOR DATA, WITH DEGREES 1,2,3,4
    % AND SAVE AS:
    % C:\Users\sahar\Desktop\matlab_figure_fitspline.pdf
    % C:\Users\sahar\Desktop\matlab_figure_fitspoly.pdf
    crossifyplotfits(data);



    % COMPARE CROSS VALIDATION RMSE FOR POLYNOMIAL AND SPLINE WITH
    % 10,100,1000 ITERATIONS. RETURN MVE,MTE MATRIX FOR THESE THREE
    % ITERATION COUNTS, PLOT EXPERIMENTS, AND SAVE AS:
    % C:\Users\sahar\Desktop\matlab_figure_pol.pdf
    % C:\Users\sahar\Desktop\matlab_figure_spline.pdf
    Mat=crossifycomp(data)
end
