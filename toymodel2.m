clear all

q = 1000;%realization
r = 2000;%t
x1 = zeros(q,r);
x2 = x1;
x3 = x1;


ep1 = x1;
ep2 = x2;
ep3 = x3;


for ii = 1:q
    %     ii = 1;
    x1(ii,1) = rand(1,1);
    x2(ii,1) = rand(1,1);
    x3(ii,1) = rand(1,1);
    
    
    
    ep1(ii,:) = normrnd(0,1,1,r);
    ep2(ii,:) = normrnd(0,1,1,r);
    ep3(ii,:) = normrnd(0,1,1,r);
    
    for i = 2:r
        if i<=500
            c13 = 0;
            c21 = 0;
            c23 = 0;
        end
        if i>500 && i<=1000
            c13 = 0+(i-500)*0.001;
            c21 = 0+(i-500)*0.001;
            c23 = 0+(i-500)*0.001;
        end
        if i>1000 && i<=1500
            c13 = 0.5-(i-1000)*0.001;
            c21 = 0.5-(i-1000)*0.001;
            c23 = 0.5-(i-1000)*0.001;
        end
        if i>1500
            c13 =0;
            c21 =0;
            c23 =0;
        end
        x1(ii,i)= 0.35 * x1(ii,i-1) + c21 * x2(ii,i-1) + ep1(ii,i);
        x2(ii,i)= 0.35 * x2(ii,i-1) + ep2(ii,i);
        x3(ii,i)= 0.35 * x3(ii,i-1) + c13 * x1(ii,i-1) + c23 * x2(ii,i-1) + ep3(ii,i);
        
    end
    x1mean=nanmean(x1,1)';
    x2mean=nanmean(x2,1)';
    x3mean=nanmean(x3,1)';
    
end
%save('toymodel2.mat','x1','x2','x3','x1mean','x2mean','x3mean');


