function n0 = n_si(lam)
% n_au
load('refractive_index.mat');
if lam<1.45
    n0 = interp1(nsire(:,1),nsire(:,2),lam)...
        +1i*interp1(nsiim(:,1),nsiim(:,2),lam);
elseif lam>= 1.45
    n0 = interp1(nsire(:,1),nsire(:,2),lam,'linear','extrap')...
        +1i*interp1(nsiim(:,1),nsiim(:,2),lam,'linear','extrap');
end
end
