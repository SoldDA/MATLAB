% Задаем ранги критериев
criteria = {'Качество зерна', 'Цена зерна', 'Транспортные расходы', 'Форма оплаты', 'Минимальная партия', 'Надежность поставки'};
ranks = [1, 2, 3, 4, 5, 6];
n = length(criteria);
matrix = [1,   3,   6,  4,  2,   5,  % Качество зерна
         1/3,  1,  1/3, 5, 1/2, 1/2,  % Цена зерна
         1/6,  3,   1,  6, 1/4, 1/2,  % Транспортные расходы
         1/4, 1/5, 1/6, 1, 1/2, 1/3,  % Форма оплаты
         1/2,  2,   4,  2,  1,   5,  % Минимальная партия
         1/5,  2,   2,  3, 1/5,  1]; % Надежность поставки

disp("Матрица парных сравнений");
disp(matrix);

row_products = prod(matrix, 2);
row_n_products = nthroot(row_products, n);
total_sum = sum(row_n_products);
normalized_weights = row_n_products / total_sum;
disp('Нахождение цен альтернатив: ');
for i = 1:size(row_n_products, 1)
    fprintf('C%d: %.4f\n', i, row_n_products(i));
end

fprintf('\nСумма цен альтернатив: %.4f\n\n', total_sum);

disp('Нахождение весов альтернатив:');
for i = 1:size(normalized_weights, 1)
    fprintf('%s: %.4f\n', criteria{i}, normalized_weights(i));
end

% Построение графика
figure;
bar(criteria, normalized_weights); 
xlabel('Критерии'); 
ylabel('Нормализованный вес');
title('Нормализованные веса критериев');
grid on;
