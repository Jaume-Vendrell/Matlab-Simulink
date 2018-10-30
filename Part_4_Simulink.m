% This code estimates the capacity when the initial capacity of the
% battery and the discharger CRate are given. The model is Temp. 
% independent but it is CRate dependent.

clear;
load('Voltage_1C_Dischage_0_Cycle.mat');
%% Setting Parameters
Simulation_length=length(Voltage_1C_Dischage_1_Cycle)-1; %% Time that will use for Simulink. 
capacity = 5.000*3600; % Total capacity in Colombs.
Initial_SOC=0; % Initial SOC of the System.
CRate=1;
R_Diff1=1;
R_Diff2=1;
R_Diff3=1;
R_Diff4=1;
R_Sei=1;
ts=timeseries(Voltage_1C_Dischage_1_Cycle(:,2));

%% Load SOCvsOCV file and Remove Duplicated Points From the SOCOCV 

SOCOCV2=xlsread('SOC-OCV2.xlsx'); %% Get the SOC-V profile from the 1/20 Discharge.
[SOCOCV,ic]=unique(SOCOCV2(:,1),'stable'); %% Find Unique points in the first column. Find as well the indices of the uniqui rows. 
SOCOCV(:,2)=SOCOCV2(ic,2); %% Copy values in the indices colum two to the new SOC-OCV. 
SOCOCV1(:,1)=flipud(SOCOCV(:,1));
SOCOCV1(:,2)=flipud(SOCOCV(:,2));
SOCOCV1(1,:)=[]; %% Delete the first number
SOCOCV1(1,2)=0; %% SOC for 2.7 is equal to 0 SOC
