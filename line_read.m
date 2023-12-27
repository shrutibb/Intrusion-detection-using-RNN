function data_1 = line_read(filename,max_len)
% Search for number of lines .  
fid = fopen(filename, 'rt');
y = 1;
while (feof(fid) == 0) && (y < max_len)
   t_line = fgetl(fid);
   data_1{y,1} = t_line;
   y = y + 1;
end
fclose(fid); 
end