function n0 = n_si3n4(lam)
% n_au
load('refractive_index.mat');
n0 = interp1(nsi3n4(:,1),nsi3n4(:,2),lam);
end

