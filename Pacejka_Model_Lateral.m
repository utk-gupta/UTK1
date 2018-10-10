clc
clear all
close all

%% Pacejka Coefficients
Pacejka_Coeff_Lateral =    [1.37E+00
-4.96E+01
-1.46E+03
-3.08E+03
-1.65E+01
0.00E+00
1.67E-01
1.08E+00
2.23E-02
1.37E-01
0.00E+00
-6.50E+01
1.18E+01
0.00E+00
0.00E+00
0.00E+00
0.00E+00
-3.23E-01
] ;
 a = Pacejka_Coeff_Lateral;                        
%% Input Parameters
m = 1.200;                         
F_z_f = m * 0.3 * 9.81; 
F_z_r = m * 0.2 * 9.81;                 % Weight Distribution 60:40.
degtorad = (pi/180);
alpha = -10:0.1:10;
Cam = 0;

%% Lateral Force Equations

C_y = a(1);

D_y_f = ((a(2) * (F_z_f)^2) + (a(3) * F_z_f)) * (1 - (a(16) * (Cam)^2)) ; 
D_y_r = ((a(2) * (F_z_r)^2) + (a(3) * F_z_r)) * (1 - (a(16) * (Cam)^2)) ; 

K_y_f = (a(4) * sin(2 * atan(F_z_f/a(5)))) * (1 - (a(6) * Cam));
K_y_r = (a(4) * sin(2 * atan(F_z_r/a(5)))) * (1 - (a(6) * Cam));                      
    
B_y_f = (K_y_f / (C_y * D_y_f));
B_y_r = (K_y_r / (C_y * D_y_r));

S_hy_f = ((a(9) * F_z_f) + a(10) + (a(11) * Cam));
S_hy_r = ((a(9) * F_z_r) + a(10) + (a(11) * Cam));
    
S_vy_f = ((a(12) * F_z_f) + a(13) + (((a(14) * F_z_f) + a(15)) * (F_z_f * Cam)));
S_vy_r = ((a(12) * F_z_r) + a(13) + (((a(14) * F_z_r) + a(15)) * (F_z_r * Cam)));   

 
for(i=1:size(alpha,2))
    alpha_y_f(i) = alpha(i) + S_hy_f;
    alpha_y_r(i) = alpha(i) + S_hy_r;
        
    E_y_f(i) = (((a(7) * F_z_f) + a(8)) * (1 - (((a(17) * Cam) + a(18)) * sign(alpha_y_f(i)))));
    E_y_r(i) = (((a(7) * F_z_r) + a(8)) * (1 - (((a(17) * Cam) + a(18)) * sign(alpha_y_r(i)))));
    
    F_y_f(i) = ( D_y_f * (sin(C_y * atan(((B_y_f * alpha_y_f(i)) - (E_y_f(i) * ((B_y_f * alpha_y_f(i)) - atan(B_y_f * alpha_y_f(i))))))))) + S_vy_f;
    F_y_r(i) = ( D_y_r * (sin(C_y * atan(((B_y_r * alpha_y_r(i)) - (E_y_r(i) * ((B_y_r * alpha_y_r(i)) - atan(B_y_r * alpha_y_r(i))))))))) + S_vy_r;
    
end

for(i=1:size(alpha,2))
    alpha_y_f(i) = alpha(i) + S_hy_f;
    alpha_y_r(i) = alpha(i) + S_hy_r;
        
   F_y_l_f(i) = K_y_f * alpha(i);
   F_y_l_r(i) = K_y_r * alpha(i);
end


plot(alpha,F_y_f,'r','linewidth', 2);
hold on;
plot(alpha,F_y_r,'b','linewidth', 2);
hold on;
plot(alpha,F_y_l_f,'c','linewidth', 2);
hold on;
plot(alpha,F_y_l_r,'k','linewidth', 2);
hold off;
xlabel('Slip Angle [Deg]')
ylabel('Cornering Force [kN]')
legend('Pacejka Model - Front','Pacejka Model - Rear','Linear Model - Front', 'Linear Model - Rear');
