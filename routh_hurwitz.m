% Sebastian De Leon
syms s K

D_s = (s+8000) * (s^2 + 16000*s + (94250)^2) * (s + 1/25000);
N_s = K * (s+1650) * (94250)^2 * 1/25000;

CE = D_s + N_s;

expanded_ce = expand(CE)

coeffs_s = coeffs(expanded_ce, s, 'All')

% 2. Initialize a 5-row, 3-column symbolic Routh array with zeros
R = sym(zeros(5, 3));

% 3. Populate the first two rows (s^4 and s^3) using the coefficients
R(1, 1) = coeffs_s(1); 
R(1, 2) = coeffs_s(3); 
R(1, 3) = coeffs_s(5);
R(2, 1) = coeffs_s(2); 
R(2, 2) = coeffs_s(4); 
R(2, 3) = 0;

% 4. Calculate the remaining rows using Routh determinant formulas
% --- s^2 row ---
R(3, 1) = (R(2,1)*R(1,2) - R(1,1)*R(2,2)) / R(2,1);
R(3, 2) = (R(2,1)*R(1,3) - R(1,1)*R(2,3)) / R(2,1);

% --- s^1 row ---
R(4, 1) = (R(3,1)*R(2,2) - R(2,1)*R(3,2)) / R(3,1);

% --- s^0 row ---
R(5, 1) = (R(4,1)*R(3,2) - R(3,1)*R(4,2)) / R(4,1);

% 5. Simplify and extract the first column for stability analysis
first_col = simplify(R(:, 1));
disp('--- First Column of the Routh Array ---');
disp(first_col);

% 6. Find the critical values of K
% For stability, EVERY term in the first column must be > 0.
% We find the boundary limits by setting the equations with K equal to 0.
disp('--- Critical Boundary Values for K ---');

disp('K value where s^2 row = 0:'); 
K_crit_s2 = double(solve(first_col(3) == 0, K));
disp(K_crit_s2);

disp('K values where s^1 row = 0:'); 
K_crit_s1 = double(solve(first_col(4) == 0, K));
disp(K_crit_s1);

disp('K value where s^0 row = 0:'); 
K_crit_s0 = double(solve(first_col(5) == 0, K));
disp(K_crit_s0);