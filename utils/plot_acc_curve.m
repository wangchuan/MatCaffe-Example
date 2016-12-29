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

persistent acc_fig print_interval
if ishandle(acc_fig)
    figure(acc_fig);
else
    acc_fig = figure('Name', 'Acc Curve', 'NumberTitle', 'off');
end
if isempty(print_interval)
    print_interval = 0;
end
print_interval = print_interval + 1;

data = [output.acc_train, output.acc_valid];
data = reshape(data, size(output.acc_train,2), []);

range = max(data(:)) - min(data(:)) + 0.001;
axis([0, size(data,1)+1, min(data(:)) - 0.1*range, max(data(:)) + 0.1*range]);
title('Accuracy Curve');
xlabel('Epoch');
ylabel('Accuracy');

series = {'Train Acc', 'Valid Acc'};
markers = {'-o', '-x'};
colors = [0.4,0.5,1.0;1.0,0.4,0.5];
ax = gca; ax.GridLineStyle = '-.';
for i = 1:size(data,2)
    p = plot(1:size(data,1), data(:,i), markers{i}, 'LineWidth', 1.5);
    set(p, 'Color', colors(i,:));
    grid on
    hold on
end
legend(series(1:size(data,2)), 'Location', 'SouthEast');

if ~exist(output.dir, 'dir')
    mkdir(output.dir);
end

if ~mod(print_interval, 10)
    print(acc_fig, fullfile(output.dir, 'Acc_Curve'),'-dpng');
    print(acc_fig, fullfile(output.dir, 'Acc_Curve'),'-depsc2');
    print(acc_fig, fullfile(output.dir, 'Acc_Curve'),'-dpdf');
end
drawnow;
end
