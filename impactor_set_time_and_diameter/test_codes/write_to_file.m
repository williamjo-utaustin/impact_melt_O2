clc;
clear;
close all;

for simulation = 1:15

    fileID = fopen(append('test_file_',num2str(simulation,'%03i'),'.txt'),'w');
    
    year = 2304;
    diameter = 12.5;
    type = 1;
    
    for i = 1:5 
        fprintf(fileID,'%4i %5.3f %1i\n',year,diameter,type);
        year = year + 1;
        diameter = diameter * 1.4;
        type = 1;
    end
    fclose('all');

end