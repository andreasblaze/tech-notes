
---
sidebar_position: 2
---
# Troubleshooting

## OOMKilled
Container in pod has been OOMKilled 1 times in the last 120 minutes. По памяти планка идет 286 Мб, т.е. до лимита 364М, вроде запасик был.
> Скорее всего киллер его прибил, потому что на ноде было недостаточно ресурсов. У вас реквесты низковатые. Только реквест гарантируется. Лимит не гарантируется. Поду просто дают жрать выше реквеста, но ниже лимита только в случае, если на ноде есть свободные ресурсы.



## Terminated With Exit Code 1
https://komodor.com/learn/how-to-fix-container-terminated-with-exit-code-1/