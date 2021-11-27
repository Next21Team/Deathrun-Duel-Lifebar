# Deathrun Duel Lifebar

_[English](README.md) | **Русский**_

![Deathrun Duel Lifebar](images/lifebar.jpg)

AMX Mod X плагин для Counter-Strike.

Плагин добавляет полоску жизни во время дуэли для мода Deathrun.

## Настройки
Конфигурация производится в файле исходного кода:
```c
#define COLOR_RED Float: { 255.0, 0.0, 0.0 } // Цвет лайфбара для команды террористов
#define COLOR_BLUE Float: { 0.0, 0.0, 255.0 } // Цвет лайфбара для команды контр-террористов
#define LIFEBAR_RENDERMODE kRenderTransTexture
#define LIFEBAR_RENDERAMT 255.0
#define LIFEBAR_SCALE 0.2 // Размер лайфбара
new const LIFEBAR_MODEL[] = "sprites/next21_efk/lifebar_def.spr" // Модель лайфбара (sprites/next21_efk/lifebar_numeric.spr для цифрового)
```

![Numeric Lifebar](images/lifebar2.jpg)

## Требования
- [DeathrunMod](https://github.com/Mistrick/DeathrunMod)

## Авторы
- [Psycrow](https://github.com/Psycrow101)
