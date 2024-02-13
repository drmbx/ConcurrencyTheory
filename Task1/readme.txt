Для сборки бинарного файла с float используйте следующую последовательность команд:
cmake .
cmake --build . --target float
Для сборки бинарного файла с double используйте следующую последовательность команд:
cmake .
cmake --build . --target double

Также можно собрать в другой директории. Для этого создадите её и перейдите в неё в терминале и используйте
cmake *путь до CMakeLists.txt*
cmake --build . --target float
или
cmake --build . --target double

для сборки обоих версий можно использовать cmake --build . --target all
