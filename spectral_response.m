clear; clc; clf;close All;

%%
addpath('Functions')
addpath 'reticolo_allege_v9'
addpath('reticolo_allege_v9/refractive index/')
load TORun_001_SGD_TM_BV1_h425_p800_wltot50_patch15_v2.mat
% load TORun_001_SGD_TM_BV0_h525_wltot50_patch5
% load TORun_00_SGD_1st_TM_3patch_corrected_0p1.mat

num_tot = 100;
list_wavelength=linspace(400,700,num_tot);
period=OptParm.Geometry.Period;% same unit as wavelength
thickness = OptParm.Geometry.Thickness;
% FinalPattern = optout.FinalPattern;
n_incident_medium=1;% refractive index of the top layer 
angle_theta=0;
k_parallel=n_incident_medium*sin(angle_theta*pi/180); 
angle_delta=0;
parm=res0;         % default parameters for "parm"
parm.res1.champ=1; % the eletromagnetic field is calculated accurately
nn= NFourier; % Fourier harmonics
textures=cell(1,3);
textures{1}= {nTop};                % uniform texture
textures{2}= {nBot};             % uniform texture
% FinalPattern = ThreshFilter(FinalPattern,100,0.5);
nPattern = FinalPattern*(nDevice - nTop) + nTop;
textures{3} = FractureGeom(nPattern,nTop,nDevice,xGrid,yGrid);
transmission_list = zeros(1,num_tot);
reflection_list = zeros(1,num_tot);
for ii = 1:num_tot
    lam = list_wavelength(ii);
    profile={[0,thickness,0],[1,3,2]};
    aa=res1(lam,period,textures,nn,k_parallel,angle_delta,parm);
    result=res2(aa,profile);
    t1 = result.TMinc_bottom_transmitted.efficiency; %transmitted/reflected
    r1 = result.TMinc_bottom_reflected.efficiency; %transmitted/reflected
%     t1 = result.TEinc_bottom_transmitted.efficiency; %transmitted/reflected
%     r1 = result.TEinc_bottom_reflected.efficiency; %transmitted/reflected
    % remember to change polarisation if needed
    transmission_list(ii) = t1((length(t1)+1)/2+1); %+sum(eff2))/2
    reflection_list(ii) = r1((length(r1)+1)/2+1); %+sum(eff2))/2
    retio;
end

%%
load comparison_thickness.mat
figure;
set(gcf, 'Position', [1000 1000 300 150]);
plot(list_wavelength,transmission125, 'Linewidth',2.5);
plot(list_wavelength,transmission225, 'Linewidth',2.5);
plot(list_wavelength,transmission325, 'Linewidth',2.5);
plot(list_wavelength,transmission425, 'Linewidth',2.5);
hold off
set(gcf,'color','w'); grid minor;
ylabel('1st order T','FontSize',14,'Interpreter','latex'); 
% set(gca,'xticklabel',{[]})
xlabel('Wavelength(nm)','FontSize',14,'Interpreter','latex');
ylim([0 1]);
% legend('h=525 nm','h=225 nm','h=325 nm','h=425 nm','h=525 nm')
h=gca; % let h = the current set of axes
h.FontSize = 14; %Set axis fontsize
h.LineWidth = 1; % Set axis linewidth
h.XMinorTick = 'on'; % Set x axis minor ticks to true
h.YMinorTick = 'on'; % Set y axis minor ticks to true
h.TickLabelInterpreter = 'latex'; % Set the axis to compile using latex
h.MinorGridAlpha = 0.25;% set the transparency of the grid

%%
load TORun_001_SGD_TM_BV1_h425_p800_wltot50_patch15_v2.mat
figure();
set(gcf, 'Position', [1000 1000 300 150]);
plot(1:249, [(FoM_leastnorm(1:249))'], 'linewidth',2); hold off;
% set(gca,'xticklabel',{[]})
xlabel('Iteration','Interpreter','latex','fontsize',14)
ylabel('||y-y_{gt}||_2^2','Interpreter','tex','fontsize',14)
h=gca; % let h = the current set of axes
h.FontSize = 14; %Set axis fontsize
h.LineWidth = 1; % Set axis linewidth
h.XMinorTick = 'on'; % Set x axis minor ticks to true
h.YMinorTick = 'on'; % Set y axis minor ticks to true
h.TickLabelInterpreter = 'latex'; % Set the axis to compile using latex
h.MinorGridAlpha = 0.25;% set the transparency of the grid

%%
load TORun_001_SGD_TM_BV1_h425_p800_wltot50_patch15_v2.mat
figure;
set(gcf, 'Position', [1000 1000 300 80]);
plot(linspace(0,1000,200),(FinalPattern(:,1)'),"LineWidth",3); %colorbar; %daspect([1 1 1]);
% set(gca,'xticklabel',{[]})

