function testing()

load Yy;
%load pref;
K=[];
for i=1:size(Yy,2)
   Y=Yy{1,i};
   
   for j=1:size(Y,2)
   
       K(i,j)=Y{1,j};
       
   end
   
end

x = sum(K);

[C I]=sort(x,'descend');

end

