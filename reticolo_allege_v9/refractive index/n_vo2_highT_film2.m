function n0 = n_vo2_highT_film2(lam)
% n_au
load('refractive_index.mat');
n0 = interp1(n_vo2_film12(:,1),n_vo2_film12(:,8),lam)...
    +1i*interp1(n_vo2_film12(:,1),n_vo2_film12(:,9),lam);
end
