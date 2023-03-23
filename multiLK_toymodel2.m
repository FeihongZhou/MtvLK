
clear

load toymodel2.mat
MAlen_shuru = 10;
NN_shuru =290;
MA_shuru = 'UWMA';
np_shuru = 1;

x1_2=x1';
x2_2=x2';
x3_2=x3';

variable_realization = length(x1_2(1,:));
%for r=1:variable_realization
for r=1:20
    [T21(:,r),err90(:,r),err95(:,r),err99(:,r)] = multiLK_code(MAlen_shuru,NN_shuru,MA_shuru,np_shuru,x2_2(:,r),x1_2(:,r));
   disp(num2str(r))
end
% [T21,err90,err95,err99] = multiLK_code(MAlen_shuru,NN_shuru,MA_shuru,np_shuru,x1,x2)
%Estimate T2->1, the information transfer from series X2 to series X1 

% [T21,err90,err95,err99] = multiLK_code(MAlen_shuru,NN_shuru,MA_shuru,np_shuru,x1,x2,x3)
%Estimate T2->1|3, the information transfer from series X2 to series X1 influenced by x3
T21mean=nanmean(T21,2);
err90mean=nanmean(real(err90),2);
err95mean=nanmean(real(err95),2);
err99mean=nanmean(real(err99),2);


