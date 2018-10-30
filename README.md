# Matlab-Simulink

The Battery_Capacity.m calculates the capacity after a given number of cycles. The initial capacity of the cell and the discharge Rate need to be set. The model is temperature independent but it is CRate dependent. (The SOC-OCV file, which is not included in the repository, is needed to run the code)

The Branched_Voltage_Final.slxc and Branched_Voltage_Final.m the cell is modeled using three voltage sources in paralel. The diffusion of lithium within the electrode is modeled by setting a resistor in-between the voltages sources. The formation of the solid electrolyte interface on the anode surface is emulated by placing a resistor in series to the electric circuit model. Ultimately the capacity is calculated for a given number of cycles.
