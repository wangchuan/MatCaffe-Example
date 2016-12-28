function plot_acc_curve(acc)
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
plot([1:numel(acc)], acc, 'b-o', 'LineWidth', 1.5);

grid on
range = max(acc) - min(acc) + 0.001;
axis([0, numel(acc)+1, min(acc) - 0.1*range, max(acc) + 0.1*range]);
title('Validation ACC');
xlabel('Epoch');
ylabel('Acc');
hold on

end
