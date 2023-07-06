function mass_O2_consumed = o2_consumption(mass_input, frac_gas)

data_file = readtable("o2_ratios.xlsx");
data_file_table = table2array(data_file);
i = 1;
mol_percent_gas = zeros(9,1);
continue_loop = true;
while continue_loop

    if frac_gas < data_file_table(i,1)
        

        for j = 2:10
                mol_percent_gas(j-1,1) = data_file_table(i-1,j) + (data_file_table(i,j) - data_file_table(i-1,j))*(frac_gas - data_file_table(i-1,1))/(data_file_table(i,1) - data_file_table(i-1,1));
        end
        continue_loop = false;
    else
        i = i + 1 ;
    end

end

mol_percent_gas = mol_percent_gas/100;
gas_mass = mass_input * frac_gas/100; 

mol_weight = [2 18 28 44 16 34 64 64 32];
O2_consupmt = [0.5 0 0.5 0 2 1.5 0 2 0];

% % compute the wt% of gas
mass_one_mol_gas = mol_weight .* mol_percent_gas';
tot_mass_one_mol_gas = sum(mass_one_mol_gas);
mass_percent_gas = mass_one_mol_gas/tot_mass_one_mol_gas;


% % compute the mass of the gas in different components
mass_gas_components = gas_mass * mass_percent_gas; % in kg


% % compute the molar components of the gas in kmol
kmol_gas_components = (mass_gas_components./mol_weight); % in kmol


% % compute the number of kmol consumed by the gas
kmol_O2_consumed = kmol_gas_components .* O2_consupmt; % in kmol of O2
mass_O2_consumed = kmol_O2_consumed * 32; % in kg of O2

end

