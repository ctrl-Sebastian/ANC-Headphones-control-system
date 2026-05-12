% Sebastian De Leon
% Open loop eq

s = tf('s')
controller = tf([1 1650], [1 8000]);
speaker = tf([94250^2], [1 16600 94250^2]);
feedback = tf([1/25000], [1 1/25000]);

open_sys = controller * speaker * feedback;

%pzplot(open_sys)
%grid on

%step(open_sys);
%stepinfo(open_sys)
%rlocus(open_sys)

% Closed loop

K = 5;

Gcontroller = K * (s + 1650) / (s + 8000);
Gspeaker = (94250)^2 / (s^2 + 16600*s + (94250)^2);

Hmic = (1/25000) / (s + 25000);

T_closed = (Gcontroller * Gspeaker) / (1 + Gcontroller * Gspeaker * Hmic);

damp(T_closed);

stepinfo(T_closed);

figure;
%step(T_closed);
grid on

