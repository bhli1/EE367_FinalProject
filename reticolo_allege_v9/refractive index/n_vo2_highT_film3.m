function n0 = n_vo2_highT_film3(lam)
% n_au
load('refractive_index.mat');
n0 = interp1(n_vo2_film34(:,1),n_vo2_film34(:,4),lam)...
    +1i*interp1(n_vo2_film34(:,1),n_vo2_film34(:,5),lam);
end
