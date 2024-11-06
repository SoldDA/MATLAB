% Задаем варианты косметических средств
products = {'Увлажняющий крем', 'Сыворотка', 'Тоник', 'Маска', 'Солнцезащитный крем', 'Гель для умывания'};
n = length(products);

% Эффективность
% Я думаю, что сыворотка и маска имеют наилучшие результаты, а гель и тоник немного уступают.
matrix_effectiveness = [1,   2,   1/3,  1,   1,   2;
                       1/2,  1,   1/4,  3,   2,   3;
                        3,   4,    1,   2,   3,   5;
                        1,  1/3,  1/2,  1,   1,   2;
                        1,  1/2,  1/3,  1,   1,   2;
                       1/2, 1/3,  1/5, 1/2, 1/2,  1];

% Безопасностность применения
% Тут сыворотка и тоник получили высокие оценки по безопасности, а другие
% средства могут вызывать аллергические реакции, а в приницпе всё может
% вызывать, но мне нравится так как я расставил.
matrix_safety = [1,   3,   5,   4,   2,   3;
                1/3,  1,   2,   3,  1/2,  1;
                1/5, 1/2,  1,   2,  1/4, 1/3;
                1/4, 1/3, 1/2,  1,  1/3, 1/5;
                1/2,  2,   4,   3,   1,   2;
                1/3,  1,   3,   5,  1/2,  1
];

% Ценовая доступность
% Почти на обум расставил, цена слишком разная. Берите, что хотите!
matrix_price = [1,   2,   4,   3,   1,   5;
               1/2,  1,   2,   2,  1/3,  3;
               1/4, 1/2,  1,  1/3, 1/4,  2;
               1/3, 1/2,  3,   1,  1/2,  4;
                1,   3,   4,   2,   1,   5;
               1/5, 1/3, 1/2, 1/4, 1/5,  1
];

% Компоненты (натуральные ингридиенты типа)
% Увлажняющий крем и солнцезащитный крем имеют активные и натуральные ингредиенты, а остальные так.
matrix_components = [1,   2,   3,   4,   5,   6;
                    1/2,  1,   2,   3,   4,   5;
                    1/3, 1/2,  1,   2,   3,   4;
                    1/4, 1/3, 1/2,  1,   2,   3;
                    1/5, 1/4, 1/3, 1/2,  1,   2;
                    1/6, 1/5, 1/4, 1/3, 1/2,  1
];

% Качество и размер упаковки
% Пусть гель для умывания имеет низкие значения.
matrix_packaging = [1,   2,   3,   4,   5,   1;
                   1/2,  1,   2,   3,   4,  1/2;
                   1/3, 1/2,  1,   2,   3,  1/3;
                   1/4, 1/3, 1/2,  1,   2,  1/4;
                   1/5, 1/4, 1/3, 1/2,  1,  1/5;
                    1,   2,   3,   4,   5,   1
];

% Отзывы пользователей (ну типа)
% Допустим сыворотка и маска имеют лучшие отзывы, а например крем нет.
matrix_reviews = [1,   3,   4,   2,   5,   2;
                 1/3,  1,   2,  1/2,  2,  1/4;
                 1/4, 1/2,  1,  1/3,  1,  1/5;
                 1/2,  2,   3,   1,   4,  1/2;
                 1/5, 1/2,  1,  1/4,  1,  1/3;
                 1/2,  4,   5,   2,   3,   1
];

weights_effectiveness = calculate_weights(matrix_effectiveness);
weights_safety = calculate_weights(matrix_safety);
weights_price = calculate_weights(matrix_price);
weights_components = calculate_weights(matrix_components);
weights_packaging = calculate_weights(matrix_packaging);
weights_reviews = calculate_weights(matrix_reviews);

disp('Эффективность:'); disp(weights_effectiveness);
disp('Безопастность:'); disp(weights_safety);
disp('Доступность:'); disp(weights_price);
disp('Компоненты:'); disp(weights_components);
disp('Качество и размер упаковки:'); disp(weights_packaging);
disp('Отзывы:'); disp(weights_reviews);


% Расчет итоговых оценок для каждого из косметических средств на основе
% различных критериев. Эффективность, безопасность, компоненты, упаковка, отзывы:
% Эти критерии положительно влияют на итоговую оценку поэтому их суммируем, 
% но цену вычитаем потому что более дорогие средства не всегда лучше по
% эффективности или качеству, нужно чтобы оно было еще и доступно.
final_scores = zeros(n, 1); 
for i = 1:n
    final_scores(i) = weights_effectiveness(i) + ...
                       weights_safety(i) - ... % Минус цена
                       weights_price(i) + ...
                       weights_components(i) + ...
                       weights_packaging(i) + ...
                       weights_reviews(i);
end

normalized_final_scores = final_scores / sum(final_scores);

[max_score, best] = max(normalized_final_scores);

% Вывод результата
fprintf('Оптимальное косметическое средство: %s с весом: %.4f\n', products{best}, max_score);

% Построение графика
figure;
bar(normalized_final_scores);
xlabel('Косметические средства'); 
ylabel('Итоговый весс');
title('Итоговые оценки косметических средств');
xticklabels(products);
grid on;

% Функция для вычисления весов из матрицы парных сравнений
function [normalized_weights] = calculate_weights(matrix)
    n = size(matrix, 1);
    row_products = prod(matrix, 2);
    row_n_products = nthroot(row_products, n);
    total_sum = sum(row_n_products);
    normalized_weights = row_n_products / total_sum;
end
