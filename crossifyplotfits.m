function crossifyplotfits(data)

% crossifyplotfits(Realdata)

close all;
x=data(:,1);
y=data(:,2); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SPLINE
rob=0.5;
pp2 = splinefit(x,y,8,2,rob);  % Piecewise linear
pp3 = splinefit(x,y,8,3,rob);  % Piecewise quadratic
pp4 = splinefit(x,y,8,4,rob);  % Piecewise cubic
pp5 = splinefit(x,y,8,5,rob);  % Piecewise quartic

fig_spline=figure()
hold on;


xx = linspace(0,max(x),1000);
y1 = ppval(pp2,xx);
y2 = ppval(pp3,xx);
y3 = ppval(pp4,xx);
y4 = ppval(pp5,xx);
plot(x,y,'DisplayName','Data','Marker','o','LineWidth',1,'LineStyle','none','Color',[1 0 1])
plot(xx,[y1;y2;y3;y4],'LineWidth',1.5)


legend('Data','Linear','Quadratic','Cubic','4th degree');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TODO ADJUST
axis( [min(x),max(x),0,80] ); % adjust y-axis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ^^^

grid on;
set(gcf,'units','points','position',[0,0,500,350])
legend('Location','northwest');
xlabel("Maximum Execution Time (MT)");
ylabel("Actual Execution Time (AT)");

% plot(X1,Y1,'DisplayName','Data','Marker','o','LineWidth',1.5,'LineStyle','none','Color',[1 0 1]);


figsave(fig_spline,'C:\Users\sahar\Desktop\matlab_figure_fitspline.pdf');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POLYNOMIAL
fig_poly=figure()
hold on;


pp1 = polyfit(x,y,1);  % Piecewise linear
pp2 = polyfit(x,y,2);  % Piecewise quadratic
pp3 = polyfit(x,y,3);  % Piecewise cubic
pp4 = polyfit(x,y,4);  % Piecewise quartic


xx = linspace(0,max(x),1000);

y1 = polyval(pp1,xx);
y2 = polyval(pp2,xx);
y3 = polyval(pp3,xx);
y4 = polyval(pp4,xx);

plot(x,y,'DisplayName','Data','Marker','o','LineWidth',1,'LineStyle','none','Color',[1 0 1])
plot(xx,[y1;y2;y3;y4],'LineWidth',1.5)


legend('Data','Linear','Quadratic','Cubic','4th degree');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TODO ADJUST
axis( [min(x),max(x),0,80] ); % adjust y-axis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ^^^

grid on;
set(gcf,'units','points','position',[0,0,500,350])
legend('Location','northwest');
xlabel("Maximum Execution Time (MT)");
ylabel("Actual Execution Time (AT)");

figsave(fig_poly,'C:\Users\sahar\Desktop\matlab_figure_fitspoly.pdf');



end
