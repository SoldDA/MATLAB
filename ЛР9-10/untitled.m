%x = (3 : 0.1 : 11);
%y = gaussmf(x, [1 7]);
%plot(x, y)

%x = (0 : 0.1 : 10);
%y = trimf(x, [3 5 7]);
%plot(x, y)

%x = (2 : 0.1 : 10);
%y = gaussmf(x, [1 6]);
%plot(x, y)

x = 0 : 0.1 : 10;
x1 = (0 : 0.1 : 10);
x2 = (2 : 0.1 : 10);
[X, Y] = meshgrid(x1, x2);
Z = min(trimf(X, [3 5 7]), gaussmf(Y, [1 6]));
Z = max(0.5 * mf1, 0.5 * mf2);
figure('Tag','defuzz');
plot(x, Z, 'LineWidth', 1)
h_gca = gca;
h_gca.YTick = [0 .45 1];
ylim([-1 1]);
grid minor;

x3 = defuzz(x, Z, 'mom');
h2.Color = gray;
t2.Color = gray;
h3 = line([x3 x3], [0.2 0.6], 'Color', 'k');
t3 = text(x3, 0.2, 'mom', 'FontWeight','bold');
fprintf("Результат дефаззификации: ");
disp(x3);

