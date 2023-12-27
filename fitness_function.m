function fitness=fitness_function(r,feature_vect)

temp_fitness =[];
for i=1:size(r,1)
    %d=0;
     for k=1:size(feature_vect,1)
            y=feature_vect(k,size(feature_vect,2));
       
            for j=1:size(r,2)
   
       
                x = feature_vect(r(i,j),size(feature_vect,2));
        
         
                d(1,j) = dist(x,y'); 
            
        
            end
        [C I]=min(d);
        temp_fitness(i,k)=C;
    
     end
end

fitness = sum(temp_fitness');

end

