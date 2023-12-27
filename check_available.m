function C=check_available(x,r,feature_vect,counter)
count=0;
nonzero=0;
C=0;
x=counter;
xx = feature_vect(x,38);
for i=1:size(r,2)

    if r(1,i)>0
    yy=feature_vect(r(1,i),38);
    
    d = dist(xx,yy');
   
    if d>10
       
        count=count+1;
    end
    nonzero=nonzero+1;
     if d==0
       break; 
    end
    end
end

if nonzero==count
   C=counter; 
end
end

