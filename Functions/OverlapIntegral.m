function FieldProductWeightedMatrix = OverlapIntegral(ForwardField_TE,ForwardField_TM,AdjointField_TE,AdjointField_TM,...
    z_step,Nx,Ny,ConstantFactor,AmpMatrix,nPattern,kPattern)
% Returns the overlap of adjoint and forward fields
% Begin to compute 3D gradient by overlap of forward and
% adjoint fields; x, y and z coordinates
FieldProduct_TE_TE = ForwardField_TE(:,:,:,1).*AdjointField_TE(:,:,:,1) + ...
    ForwardField_TE(:,:,:,2).*AdjointField_TE(:,:,:,2) + ForwardField_TE(:,:,:,3).*AdjointField_TE(:,:,:,3);
FieldProduct_TE_TM = ForwardField_TE(:,:,:,1).*AdjointField_TM(:,:,:,1) + ...
    ForwardField_TE(:,:,:,2).*AdjointField_TM(:,:,:,2) + ForwardField_TE(:,:,:,3).*AdjointField_TM(:,:,:,3);
FieldProduct_TM_TE = ForwardField_TM(:,:,:,1).*AdjointField_TE(:,:,:,1) + ...
    ForwardField_TM(:,:,:,2).*AdjointField_TE(:,:,:,2) + ForwardField_TM(:,:,:,3).*AdjointField_TE(:,:,:,3);
FieldProduct_TM_TM = ForwardField_TM(:,:,:,1).*AdjointField_TM(:,:,:,1) + ...
    ForwardField_TM(:,:,:,2).*AdjointField_TM(:,:,:,2) + ForwardField_TM(:,:,:,3).*AdjointField_TM(:,:,:,3);

% N_m = Em x H-m - E-m x Hm and take z component
FieldCross_TE_TE = (ForwardField_TE(end,:,:,1).*AdjointField_TE(end,:,:,5) - ForwardField_TE(end,:,:,2).*AdjointField_TE(end,:,:,4)...
    - (AdjointField_TE(end,:,:,1).*ForwardField_TE(end,:,:,5) - AdjointField_TE(end,:,:,2).*ForwardField_TE(end,:,:,4)));
FieldCross_TE_TM = (ForwardField_TE(end,:,:,1).*AdjointField_TM(end,:,:,5) - ForwardField_TE(end,:,:,2).*AdjointField_TM(end,:,:,4)...
    - (AdjointField_TM(end,:,:,1).*ForwardField_TE(end,:,:,5) - AdjointField_TM(end,:,:,2).*ForwardField_TE(end,:,:,4)));
FieldCross_TM_TE = (ForwardField_TM(end,:,:,1).*AdjointField_TE(end,:,:,5) - ForwardField_TM(end,:,:,2).*AdjointField_TE(end,:,:,4)...
    - (AdjointField_TE(end,:,:,1).*ForwardField_TM(end,:,:,5) - AdjointField_TE(end,:,:,2).*ForwardField_TM(end,:,:,4)));
FieldCross_TM_TM = (ForwardField_TM(end,:,:,1).*AdjointField_TM(end,:,:,5) - ForwardField_TM(end,:,:,2).*AdjointField_TM(end,:,:,4)...
    - (AdjointField_TM(end,:,:,1).*ForwardField_TM(end,:,:,5) - AdjointField_TM(end,:,:,2).*ForwardField_TM(end,:,:,4)));

% Normalise N_m with amplitude
N_m_TE_TE = sum(FieldCross_TE_TE,'all')/(Nx*Ny);
N_m_TE_TM = sum(FieldCross_TE_TM,'all')/(Nx*Ny);
N_m_TM_TE = sum(FieldCross_TM_TE,'all')/(Nx*Ny);
N_m_TM_TM = sum(FieldCross_TM_TM,'all')/(Nx*Ny);

ScalingFactor_TE_TE = ConstantFactor/N_m_TE_TE;
ScalingFactor_TE_TM = ConstantFactor/N_m_TE_TM;
ScalingFactor_TM_TE = ConstantFactor/N_m_TM_TE;
ScalingFactor_TM_TM = ConstantFactor/N_m_TM_TM;

ScalingFactor_TE_TE(isnan(ScalingFactor_TE_TE)) = 0; % Replace NaN with zeros
ScalingFactor_TE_TM(isnan(ScalingFactor_TE_TM)) = 0; % Replace NaN with zeros
ScalingFactor_TM_TE(isnan(ScalingFactor_TM_TE)) = 0; % Replace NaN with zeros
ScalingFactor_TM_TM(isnan(ScalingFactor_TM_TM)) = 0; % Replace NaN with zeros

FieldProductWeightedMatrix{1,1} = (nPattern+1i*kPattern).*squeeze(sum(ScalingFactor_TE_TE*z_step*FieldProduct_TE_TE*AmpMatrix(1,1),1));
FieldProductWeightedMatrix{2,1} = (nPattern+1i*kPattern).*squeeze(sum(ScalingFactor_TE_TM*z_step*FieldProduct_TE_TM*AmpMatrix(2,1),1));
FieldProductWeightedMatrix{1,2} = (nPattern+1i*kPattern).*squeeze(sum(ScalingFactor_TM_TE*z_step*FieldProduct_TM_TE*AmpMatrix(1,2),1));
FieldProductWeightedMatrix{2,2} = (nPattern+1i*kPattern).*squeeze(sum(ScalingFactor_TM_TM*z_step*FieldProduct_TM_TM*AmpMatrix(2,2),1));

end

