function n0 = n_vo2_lowT_film1(lam)
% n_au
load('refractive_index.mat');
n0 = interp1(n_vo2_film12(:,1),n_vo2_film12(:,2),lam)...
    +1i*interp1(n_vo2_film12(:,1),n_vo2_film12(:,3),lam);
end

