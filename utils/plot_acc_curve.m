function plot_acc_curve(output)
% % Define values for x, y1, and y2
% x  = 0: .1 : 2*pi;
% y1 = cos(x);
% y2 = sin(x);
% 
% % Plot y1 vs. x (blue, solid) and y2 vs. x (red, dashed)
% figure
% plot(x, y1, 'b', x, y2, 'r-.', 'LineWidth', 2)
% 
% % Turn on the grid
% grid on
% 
% % Set the axis limits
% axis([0 2*pi -1.5 1.5])
% 
% % Add title and axis labels
% title('Trigonometric Functions')
% xlabel('angle')
% ylabel('sin(x) and cos(x)')
figure(2);
data = [output.acc_train, output.acc_valid];
data = reshape(data, size(output.acc_train,2), []);

range = max(data(:)) - min(data(:)) + 0.001;
axis([0, size(data,1)+1, min(data(:)) - 0.1*range, max(data(:)) + 0.1*range]);
title('Accuracy Curve');
xlabel('Epoch');
ylabel('Accuracy');

series = {'Train Acc', 'Valid Acc'};
colors = {'b-o', 'r-x'};
for i = 1:size(data,2)
    plot(1:size(data,1), data(:,i), colors{i}, 'LineWidth', 1.5); 
    grid on
    hold on
end
legend(series(1:size(data,2)), 'Location', 'SouthEast');

if ~exist(output.dir, 'dir')
    mkdir(output.dir);
end
print('-f2', fullfile(output.dir, 'Acc_Curve'),'-dpng');
print('-f2', fullfile(output.dir, 'Acc_Curve'),'-depsc2');
print('-f2', fullfile(output.dir, 'Acc_Curve'),'-dpdf');

end
