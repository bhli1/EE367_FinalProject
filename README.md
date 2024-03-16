# Meta-Grating Spectral Beam Deflector with Topology Optimization and Stochastic Gradient Descent Algorithm

## Run the main script:
To run the main script with the optimization process, you can directly run the script "RunOpt.m" within the folder "Metagrating-Topology-Optimizatiom-v0". The default is run with the optimal performance for wavelength-indepenent unitary 1st-order diffraction, where the grating geometry is given as period=800nm, thickness=425nm, stochastic patch size=5. The default ground truth spectrum is set to be 100% across visible spectrum, which can be modified using the parameter list_wl. The target diffraction channel is set to be the first order one, specified as OptParm.Optimization.Target = [1]. 

The optimization procedure is contained in file "OptimizeDevice.m", while the optimization is initialized by function in the Initialize.m in the "Functions" folder. Feel free to modify the parameters of interest.

The main data generated from the algorithm are named "TORun_001_SGD_TM_...". where other .mat data files are some previous attempts.

## Reproduce the plots in the report:
To reproduce the plots please run script "spectral_response.m", where the fist section calculate the transmission spectrum while the second, third and fourth section generates the plot for the case with different thicknesses, periodicities and patch sizes. The powerpoint containing all the plots are also included in the folder. 

The topology optimization package I used is based on: https://github.com/jonfanlab/Metagrating-Topology-Optimization
[MetaNet: A new paradigm for data sharing in photonics research<br>](https://arxiv.org/abs/2002.03050)
Jiaqi Jiang, Robert Lupoiu, Evan W. Wang, David Sell, Jean Paul Hugonin, Philippe Lalanne, Jonathan A. Fan

It is based on the Rigorous coupled wave analysis (RCWA) electromagnetic solver developed: published on https://arxiv.org/abs/2101.00901. The package can be downloaded from the website: https://www.lp2n.institutoptique.fr/equipes-de-recherche-du-lp2n/light-complex-nanostructures. 

===============The End==================



