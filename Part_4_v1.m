% This code estimates the capacity when the initial capacity of the
% battery and the discharger CRate are given. The model is Temp. 
% independent but it is CRate dependent. 
clear;

%% Setting Parameters

cycles=50; % Number of cycles will calculate the capacity.
CRate=5; % Discharge C-Rate
capacity = 4.396*3600; % Total capacity in Colombs.

%% Load SOC vs OCV file and Remove Duplicated Points From the SOCOCV 

SOCOCV2=xlsread('SOC-OCV2.xlsx'); %% Get the SOC-V profile from the 1/20 Discharge.
[SOCOCV,ic]=unique(SOCOCV2(:,1),'stable'); %% Find Unique points in the first column. Find as well the indices of the uniqui rows. 
SOCOCV(:,2)=SOCOCV2(ic,2); %% Copy values in the indices colum two to the new SOC-OCV. 
SOCOCV1(:,1)=flipud(SOCOCV(:,1));
SOCOCV1(:,2)=flipud(SOCOCV(:,2));

%% Fitting Curve For the Internal Resistance Vs C-Rate

CRate_data=[1;2;5;10]; 
Resistance_data=[11.07393467;10.52552733;9.930686333;8.867693902]/1000;
Resistance_Fit=fit(CRate_data,Resistance_data,'poly2');
R=Resistance_Fit(CRate);

%% Coding the capacity

SOC(1,1) = 99.99; % Set SOC(1) to 100.
OCV(1) = interp1(SOCOCV(:,2),SOCOCV(:,1),SOC(1)); % Set initial capacity equal to zero because the battery is fully discharge.
time=1; % Time step is set to 1 second. 
V(1:cycles,1)=4.2;
t(1:cycles,1)=zeros;

n=0;
for i = 1:cycles % Calculate the Capacity for 31 Cycles
    while V(i,1)>=2.7
        V1(i+n,1) = OCV(i)-(CRate*5)*R; % Calculate the voltage between electrodes for each time step. 
        V(i,1) = OCV(i)-(CRate*5)*R; % Calculate the voltage between electrodes.
        SOC(i,1) = SOC(i,1)-CRate*5*time/capacity*100; % Calculate the new SOC.
        OCV(i,1) = interp1(SOCOCV(:,2),SOCOCV(:,1),SOC(i,1)); % Interpolate to find the OCV based on the new SOC.
        t(i,1)=t(i,1)+1; % Variable to track time in seconds for each cycle.
        n=n+1;
    end
        % Set SOC and OCV to the initial conditions for the next dis. cycle
        SOC(i+1,1)=99.99;
        OCV(i+1,1) = interp1(SOCOCV(:,2),SOCOCV(:,1),SOC(i+1));
        R=R+0.00005; % Increment of resistance to simulate decrease in capacity.
        n=n-1;
end

Capacity(:,1)=t(:,1)*CRate*5/3600*1000; %% Measure the capacity in mAh. 

%% Plot the Modeled Voltage

x=(1:1:length(V1));
plot(x,V1(:,1))
legend('Modeled Voltage')
xlabel('Time (seconds)'); ylabel('Voltage (V)');
