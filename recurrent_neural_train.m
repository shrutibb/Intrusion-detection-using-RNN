function final_time=recurrent_neural_train(max_len)
% 
% [X,T] = simpleseries_dataset;
% %net = timedelaynet(1:2,10)
% net=layrecnet(1:2,10,'trainlm');
% [Xs,Xi,Ai,Ts] = preparets(net,X,T)
% net = train(net,Xs,Ts,Xi,Ai);
% view(net)
% Y = net(X,Xi,Ai);
% perf = perform(net,Y(1,1:98),Ts)

%max_len = 7000;%str2num(get(handles.edit_data_size,'string'));
tr_ratio = 0.5;%str2num(get(handles.edit_ratio,'string'));
testing_data_size = max_len;
training_data_size = max_len*tr_ratio;
feature_loc = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40];

total_epochs = 5;%str2num(get(handles.edit_epochs_1,'string'));
layer_neurons = [5,3];


%-------------------------------------------------------------------

%max_len = 10000;%str2num(get(handles.edit_data_size,'string'));

%-----------------------------------------------------------

i=2;
 x=num2str(i);
y=num2str(i+max_len);
st =strcat('E',x,':AV',y)
[num1,txt1,raw1] = xlsread('dataset_final.xlsx',st);
num1=[];
txt1=[];
count=1;

classes = {'normal','dos','probe','r2l','u2r'};
class_1 = {'normal'};
class_2 = {'back','land','neptune','pod','smurf','teardrop'};
class_3 = {'ipsweep','nmap','portsweep','satan'};
class_4 = {'ftp_write','guess_passwd','imap','multihop','phf','spy','warezclient','warezmaster'};
class_5 = {'buffer_overflow','loadmodule','perl','rootkit'};
sub_classes = {class_1,class_2,class_3,class_4,class_5};


for j=1:size(raw1,1)

    for k=6:42
   temp =raw1{j,k};
   feature_vect(count,k-5) = temp;
    end
   feature_class{count,1}=raw1{j,43};
   count=count+1;
   
end

%--------------------------------------------------


% data_1 = line_read('dataset2',max_len+1);
% [lines_1 col] = size(data_1);
% %feature_loc = [5,6,7,8,11,12,14,22];
% 
% 
% 
% 
% for i = 1:lines_1
%     temp_str = data_1{i,1};
%     loc = strfind(temp_str,',');
%     
%     
%     
%     for j = 1:size(feature_loc,2)
%         feature_vect(i,j) = str2num(temp_str(loc(feature_loc(1,j) - 1)+1:loc(feature_loc(1,j))-1));
%     end
%     feature_class{i,1} = temp_str(loc(end)+1:end-1);
%     
%     
% end


[row col] = size(feature_class);
chked = zeros(row,1);
m = 1;
for i = 1:row 
    temp_1 = feature_class{i,1};
    k = 1;
    if ~(chked(i,1))
        for j = i:row
            temp_2 = feature_class{j,1};
            if strcmp(temp_1,temp_2) && ~(chked(j,1))
                feature_class_index{m,1} = feature_class{i,1};
                feature_class_index{m,2} = k;
                chked(j,1) = 1;
                k = k + 1;
            end
        end
        m = m + 1;
    end
end

[row col] = size(feature_class);
[row1 col1] = size(feature_class_index);

for i = 1:row 
    temp_1 = feature_class{i,1};
    for j = 1:row1
        temp_2 = feature_class_index{j,1};
        if strcmp(temp_1,temp_2)
            feature_class_num(i,1) = j;
        end
    end
end

[row col] = size(feature_class);
[row1 col1] = size(feature_class_index);
feature_class_data = cell(1,row1);
for i = 1:row 
    temp_1 = feature_class{i,1};
    for j = 1:row1
        temp_2 = feature_class_index{j,1};
        if strcmp(temp_1,temp_2)
            feature_class_num(i,1) = j;
            feature_class_data{1,j} = [feature_class_data{1,j}; feature_vect(i,:)]; 
        end
    end
end

classes = {'normal','dos','probe','r2l','u2r'};
class_1 = {'normal'};
class_2 = {'back','land','neptune','pod','smurf','teardrop'};
class_3 = {'ipsweep','nmap','portsweep','satan'};
class_4 = {'ftp_write','guess_passwd','imap','multihop','phf','spy','warezclient','warezmaster'};
class_5 = {'buffer_overflow','loadmodule','perl','rootkit'};
sub_classes = {class_1,class_2,class_3,class_4,class_5};

feature_class_data_temp = cell(1,5);
for k = 1:5
    l = size(sub_classes{1,k},2);
    for j = 1:l
        for i = 1:size(feature_class_index,1)
            if strcmp(sub_classes{1,k}(1,j),feature_class_index{i,1})
                feature_class_data_temp{1,k} = [feature_class_data_temp{1,k}; feature_class_data{1,i}]; 
            end
        end
    end
end

k = 1;
for i = 1:5
    if ~isempty(feature_class_data_temp{1,i})
        feature_class_data_final{1,k} = feature_class_data_temp{1,i};
        classes_final{1,k} = classes{1,i};
        k = k + 1;
    end
end
P = [];
T = [];
R = training_data_size/max_len;
for i = 1:size(classes_final,2)
    val = size(feature_class_data_final{1,i},1);
    val = ceil(val*R);
    temp = feature_class_data_final{1,i};
    P = [P; temp(1:val,:)];
    T = [T; ones(val,1)*i];
end    

X = feature_vect(1:training_data_size,:)';
T = feature_class_num(1:training_data_size,:)';

for i=1:size(X,2)
    Tt{1,i}=T(1,i);
    for j=1:size(X,1)
   
       % Xx{j,i}=X(j,i);
        
    end
end
net=layrecnet();%500,10,'trainlm');
%net = timedelaynet(1:2,10)
 view(net);
st_time=tic;
 for i=1:1%size(X,1)
    [C I] = max(X(i,:));
    maax= C;
    [C I] = min(X(i,:));
    miin= C;
    for j=1:size(X,2)
   
        Xx{1,j}=(X(i,j)-miin)/(maax-miin);
        
    end
[Xs,Xi,Ai,Ts] = preparets(net,Xx,Tt);
%Ts
net.trainParam.epochs = 1;
net = train(net,Xs,Ts,Xi,Ai);

% Ai_x{1,i}=Ai;
% 
% Y = net(Xx,Xi,Ai_x{1,i});
% perf{1,i} = perform(net,Y,Tt);

 end
final_time=toc(st_time);
%  %save net.mat net;
%  save Ai_x.mat Ai_x;
%  save Xi.mat Xi;

% Y = net(Xx,Xi,Ai);
% perf = perform(net,Y(1,1:98),Ts);
% 
% 
%  net = newff(P,T,layer_neurons);
% net.trainParam.epochs = total_epochs;
% net.trainParam.goal = 0.01;
% net.trainParam.show = 1;
% net.trainParam.mc = 0.9;
% net.trainParam.max_fail = 10000;
% net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.8;
% net.divideParam.valRatio = 0.1;
% net.divideParam.testRatio = 0.1;
% tic;
% net_ff = train(net,P,T);

end