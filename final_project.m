% Sebastian De Leon
% Open loop eq

open_sys = tf([(94250^2) (1000*(94250^2))], [25000 615000001 225396562524600 1776612509015862500 71064500000000])

controlSystemDesigner(open_sys)