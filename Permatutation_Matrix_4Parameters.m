function pm = Permat4(A, B, C, D)
%% Defining the matrix
    row = size(B,2) * size(A,2) * size(C,2) * size(D,2);
    pm = zeros(row,4);                                                              
    counter= 1;
    %% Permutation and Combinations of all the Matrices
   for (l=1:size(D,2))
        for(i=1:size(A,2))
            for(j=1:size(B,2))
                for(k=1:size(C,2))
                    pm(counter,1) = A(i);
                    pm(counter,2) = B(j) ;
                    pm(counter,3) = C(k) ;
                    pm(counter,4) = D(l) ;
                    counter=counter+1;
                end 
            end
        end
    end
end

