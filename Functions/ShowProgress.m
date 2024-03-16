function [] = ShowProgress(OptParm, Grid, Pattern, iter, MaxIterations, AbsoluteEfficiency, RelativeEfficiency, Figs, FoM_list, FoM_leastnorm)
% AbsoluteEfficiency(iter,wavelengthIter,robustIter,polIter)
    Display = OptParm.Display;
    if isfield(Figs, 'FigGeo')
        FigGeo = Figs.FigGeo;
    end
    if Display.PlotGeometry % Plot geometry
        set(groot,'CurrentFigure',FigGeo);
        imagesc(Grid{1}, Grid{2},Pattern'); colorbar; daspect([1 1 1]);
        drawnow; 
    end
    
    if Display.ShowText % Print efficiencies
        if (size(AbsoluteEfficiency,3)==1) && (size(AbsoluteEfficiency,4)==2)
            fprintf('Iteration: %d of %d \n',iter,MaxIterations);
            disp([sprintf('Absolute Efficiencies (TE,TM): '),sprintf('%.4f   ',AbsoluteEfficiency(iter,:,1,:))]);
            disp([sprintf('Relative Efficiencies (TE,TM): '),sprintf('%.4f   ',RelativeEfficiency(iter,:,1,:))]);
        elseif (size(AbsoluteEfficiency,3)==1) && (size(AbsoluteEfficiency,4)==1)
            fprintf('Iteration: %d of %d \n',iter,MaxIterations);
            disp([sprintf('Absolute Efficiencies: '),sprintf('%.4f   ',AbsoluteEfficiency(iter,1))]);
            disp([sprintf('Relative Efficiencies: '),sprintf('%.4f   ',RelativeEfficiency(iter,1))]);
        else
            fprintf('Iteration: %d of %d \n',iter,MaxIterations);
            disp([sprintf('Absolute Efficiencies: '),sprintf('%.4f   ',mean(mean(AbsoluteEfficiency(iter,:,:,:),4),3))]);
            disp([sprintf('Relative Efficiencies: '),sprintf('%.4f   ',mean(mean(RelativeEfficiency(iter,:,:,:),4),3))]);
        end
    end
    
    % Plot efficiency trend over optimziation
    if isfield(Figs, 'FigEff')
        FigEff = Figs.FigEff;
    end
    if Display.PlotEfficiency
        set(groot, 'CurrentFigure', FigEff);
        if iter>1
            plot(1:iter, [mean(mean(AbsoluteEfficiency(1:iter,:,:,:),4),3)'], 'linewidth',2)
%             plot(1:iter, [(FoM_list(1:iter))'], 'linewidth',2); hold on;
            plot(1:iter, [(FoM_leastnorm(1:iter))'], 'linewidth',2); hold off;
%             legend(cellstr(num2str(OptParm.Input.WavelengthRange')))
            xlabel('Iteration')
            ylabel('FoM to be minimized...')
            set(gca, 'linewidth',2, 'fontsize', 20);
            drawnow
        end
    end
    
end