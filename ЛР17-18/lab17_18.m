%Генерирует 100 точек для каждого из x1 и x2 в диапазоне от -1 до 1.
%Создает сетку точек с помощью meshgrid().
%Вычисляет значения выходной функции для каждой пары (x1, x2).
%Сохраняет результаты в файл 'training_data.dat' в текущей директории.

min_val = -1;
max_val = 1;
num_points = 6;

x1 = linspace(min_val, max_val, num_points);
x2 = linspace(min_val, max_val, num_points);

[X1, X2] = meshgrid(x1, x2);

Y = (1 - X1^2) + 3 * (1 + X2)^2;
% dlmwrite('training_data.dat', [X1(:), X2(:), Y(:)], 'delimiter', '\t');

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Строим поверхность
% figure('Name', 'Теоретическая функция');
% surf(X1, X2, Y);
% xlabel('X_1');
% ylabel('X_2');
% zlabel('f(X_1, X_2)');
% title('Теоретическая функция f(x1, x2) = (1 - (x_1)^2) + 3 * (1 + x_2)^2');
% colorbar;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Векторизуем данные
X = [X1(:), X2(:)];
y_true = Y(:);
disp(y_true);