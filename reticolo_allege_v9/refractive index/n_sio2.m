function n0 = n_sio2(lam)
% refractive index of silica (SiO2)
load('refractive_index.mat');
n0 = interp1(nsio2(:,1),nsio2(:,2),lam);
end

