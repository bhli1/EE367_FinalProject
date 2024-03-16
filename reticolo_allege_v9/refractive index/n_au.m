function n0 = n_au(lam)
% n_au
load('refractive_index.mat');
n0 = interp1(n_au_re(:,1),n_au_re(:,2),lam)...
    +1i*interp1(n_au_im(:,1),n_au_im(:,2),lam);
end

