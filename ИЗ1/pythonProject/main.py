import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt

# Определение входных переменных
price = ctrl.Antecedent(np.arange(0, 100000, 100), 'price') # Цена
capacity = ctrl.Antecedent(np.arange(5, 15, 0.1), 'capacity') # Вместимость
energy_efficiency = ctrl.Antecedent(np.arange(0, 10, 0.1), 'energy_efficiency') # энергоэффективность
noise_level = ctrl.Antecedent(np.arange(30, 80, 0.1), 'noise_level') # уровень шума

# Определение выходной переменной
quality = ctrl.Consequent(np.arange(0, 11, 0.1), 'quality')

# Функции принадлежности для входных переменных
price['low'] = fuzz.trapmf(price.universe, [0, 0, 20000, 30000])
price['medium'] = fuzz.trimf(price.universe, [20000, 40000, 60000])
price['high'] = fuzz.trapmf(price.universe, [50000, 60000, 100000, 100000])

capacity['small'] = fuzz.trapmf(capacity.universe, [5, 5, 7, 8])
capacity['medium'] = fuzz.trimf(capacity.universe, [7, 9, 11])
capacity['large'] = fuzz.trapmf(capacity.universe, [10, 11, 15, 15])

energy_efficiency['low'] = fuzz.trapmf(energy_efficiency.universe, [0, 0, 2, 3])
energy_efficiency['medium'] = fuzz.trimf(energy_efficiency.universe, [2, 4.5, 7])
energy_efficiency['high'] = fuzz.trapmf(energy_efficiency.universe, [6, 7, 10, 10])

noise_level['quiet'] = fuzz.trapmf(noise_level.universe, [30, 30, 45, 50])
noise_level['average'] = fuzz.trimf(noise_level.universe, [45, 57.5, 70])
noise_level['loud'] = fuzz.trapmf(noise_level.universe, [65, 70, 80, 80])

# Функции принадлежности для выходной переменной
quality['poor'] = fuzz.trapmf(quality.universe, [0, 0, 2, 3])
quality['average'] = fuzz.trimf(quality.universe, [2, 4.5, 7])
quality['good'] = fuzz.trapmf(quality.universe, [6, 7, 10, 10])

# Правила нечеткого вывода
# Цена
# Вместимость
# энергоэффективность
# уровень шума
rule1 = ctrl.Rule(price['low'] & capacity['small'] & energy_efficiency['low'] & noise_level['quiet'], quality['poor'])
rule2 = ctrl.Rule(price['medium'] & capacity['medium'] & energy_efficiency['medium'] & noise_level['average'], quality['average'])
rule3 = ctrl.Rule(price['high'] & capacity['large'] & energy_efficiency['high'] & noise_level['loud'], quality['good'])

rule4 = ctrl.Rule(price['low'] & capacity['small'] & energy_efficiency['medium'] & noise_level['average'], quality['poor'])
rule5 = ctrl.Rule(price['low'] & capacity['small'] & energy_efficiency['high'] & noise_level['quiet'], quality['poor'])
rule6 = ctrl.Rule(price['medium'] & capacity['small'] & energy_efficiency['high'] & noise_level['quiet'], quality['poor'])
rule7 = ctrl.Rule(price['high'] & capacity['small'] & energy_efficiency['high'] & noise_level['loud'], quality['poor'])

rule8 = ctrl.Rule(price['low'] & capacity['medium'] & energy_efficiency['medium'] & noise_level['average'], quality['average'])
rule9 = ctrl.Rule(price['medium'] & capacity['medium'] & energy_efficiency['low'] & noise_level['average'], quality['average'])
rule10 = ctrl.Rule(price['high'] & capacity['medium'] & energy_efficiency['high'] & noise_level['average'], quality['good'])

rule11 = ctrl.Rule(price['low'] & capacity['large'] & energy_efficiency['medium'] & noise_level['loud'], quality['average'])
rule12 = ctrl.Rule(price['medium'] & capacity['large'] & energy_efficiency['low'] & noise_level['loud'], quality['average'])
rule13 = ctrl.Rule(price['high'] & capacity['large'] & energy_efficiency['low'] & noise_level['loud'], quality['good'])

rule14 = ctrl.Rule(price['low'] & capacity['small'] & energy_efficiency['medium'] & noise_level['average'], quality['poor'])
rule15 = ctrl.Rule(price['low'] & capacity['medium'] & energy_efficiency['high'] & noise_level['quiet'], quality['poor'])
rule16 = ctrl.Rule(price['medium'] & capacity['large'] & energy_efficiency['high'] & noise_level['quiet'], quality['good'])

rule17 = ctrl.Rule(price['high'] & capacity['small'] & energy_efficiency['medium'] & noise_level['average'], quality['average'])
rule18 = ctrl.Rule(price['low'] & capacity['large'] & energy_efficiency['high'] & noise_level['loud'], quality['good'])
rule19 = ctrl.Rule(price['medium'] & capacity['small'] & energy_efficiency['low'] & noise_level['average'], quality['poor'])

# Создание системы управления
quality_ctrl = ctrl.ControlSystem([rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9, rule10, rule11, rule12, rule13, rule14, rule15, rule16, rule17, rule18, rule19])
quality_sim = ctrl.ControlSystemSimulation(quality_ctrl)

# Ввод входных данных
price_input = 40000
capacity_input = 9
energy_efficiency_input = 5
noise_level_input = 55

quality_sim.input['price'] = price_input
quality_sim.input['capacity'] = capacity_input
quality_sim.input['energy_efficiency'] = energy_efficiency_input
quality_sim.input['noise_level'] = noise_level_input

# Выполнение симуляции
quality_sim.compute()

# Вывод результатов
print(f"Входные данные:")
print(f"Цена: {price_input}")
print(f"Объем барабана: {capacity_input} кг")
print(f"Энергоэффективность: {energy_efficiency_input}")
print(f"Уровень шума: {noise_level_input} дБ")
print(f"\nРезультат: Качество стиральной машины - {quality_sim.output['quality']}")

# Визуализация результатов


# plt.subplot(2, 3, 1)
# price.view(sim=quality_sim)
# plt.title('Цена')

# plt.subplot(2, 3, 2)
# capacity.view(sim=quality_sim)
# plt.title('Объем барабана')

# plt.subplot(2, 3, 3)
# energy_efficiency.view(sim=quality_sim)
# plt.title('Энергоэффективность')

# plt.subplot(2, 3, 4)
# noise_level.view(sim=quality_sim)
# plt.title('Уровень шума')

plt.subplot(2, 3, 5)
quality.view(sim=quality_sim)
plt.title('Качество стиральной машины')

plt.tight_layout()
plt.show()

