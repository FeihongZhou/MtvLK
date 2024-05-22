function [dd,err90,err95,err99] = multiLK_code(MAlen_shuru,NN_shuru,MA_shuru,np_shuru,varargin)


MAlen = MAlen_shuru;
NN = NN_shuru;
MA =MA_shuru;

variable_num = length(varargin);
Variable_length = length(varargin{1}(:,1));

M = variable_num;
nm = Variable_length;
N = Variable_length;
np = np_shuru;
dt = 1;


for k=1:variable_num
    xx(:,k)=varargin{k};
end

for k=1:variable_num
    xx2(k,:)=xx(:,k)';
end

for k=1:variable_num
    nx(k,:) = xx2(k,1:N-1);
end


fx1 = xx2(1,2:N) - xx2(1,1:N-1);

y=cat(1,nx(1,:));
for k=1:variable_num-1
    y=cat(1,y,nx(k+1,:));
end

for k=1:variable_num
    c(:,:,k) = cat(1,nx(k,:),fx1);
end

[x_kf_1, R_1] = SquareRootKalmanFilter2(y,MAlen,NN,MA);
Z=R_1;

for k=1:variable_num
    [x_kf(:,:,k), R(:,:,:,k)] = SquareRootKalmanFilter2(c(:,:,k),MAlen,NN,MA);
end

for k=1:variable_num
    dZ(k,1,:) = R(1,2,:,k);
end

x(:,1:M) = xx(1:nm-np,1:M);
N2 = nm-np;
dx1(:,1) = (xx(1+np:nm, 1) - xx(1:nm-np, 1)) / (np*dt);

for t = 2:N-1
    a1n_merge(:,:,t) = inv(Z(:,:,t)) * dZ(:,:,t);
    T_2_1(t,1) = (Z(1,2,t)/Z(1,1,t)) * a1n_merge(2,1,t);
    f1 = mean(dx1);
    for k = 1 : M
        f1 = f1 - a1n_merge(k,1,t) * mean(x(:,k));
    end
    R1  = dx1 - f1 ;
    for k = 1 : M
        R1 = R1 - a1n_merge(k,1,t) * x(:,k);
    end
    Q1 = sum(R1 .* R1);
    b1 = sqrt(Q1 * dt / N2);
    NI(1,1) = N2 * dt /b1/b1;
    NI(M+2,M+2) = 3*dt/b1^4 *sum(R1 .* R1) - N2/b1/b1;
    for k = 1 : M
        NI(1,k+1) = dt/b1/b1 * sum(x(:,k));
    end
    NI(1,M+2) = 2*dt/b1^3 *sum(R1);
    for k = 1 : M
        for j = 1 : M
            NI(j+1,k+1) = dt/b1/b1 * sum(x(:,j) .* x(:,k));
        end
    end
    for k = 1 : M
        NI(k+1,M+2) = 2*dt/b1^3 * sum(R1 .* x(:,k));
    end
    for j = 1 : M+2
        for k = 1 : j
            NI(j,k) = NI(k,j);
        end
    end
    invNI = inv(NI);
    var_a12 = invNI(3,3);
    var_T21(t,1) = (Z(1,2,t)/Z(1,1,t))^2 * var_a12;
    z99 = 2.56;
    z95 = 1.96;
    z90 = 1.65;
    err90(t,1) = sqrt(var_T21(t,1)) * z90;
    err95(t,1) = sqrt(var_T21(t,1)) * z95;
    err99(t,1) = sqrt(var_T21(t,1)) * z99;

end
%T21zheng=T_2_1;
T21zheng=abs(T_2_1);
%err99=real(err99);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mideavar = varargin{1};
varargin{1} = varargin{2};
varargin{2} = mideavar;

for k=1:variable_num
    xx(:,k)=flipud(varargin{k});
end

for k=1:variable_num
    xx2(k,:)=xx(:,k)';
end

for k=1:variable_num
    nx(k,:) = xx2(k,1:N-1);
end

fx1 = xx2(1,2:N) - xx2(1,1:N-1);

y=cat(1,nx(1,:));
for k=1:variable_num-1
    y=cat(1,y,nx(k+1,:));
end

for k=1:variable_num
    c(:,:,k) = cat(1,nx(k,:),fx1);
end

[x_kf_1, R_1] = SquareRootKalmanFilter2(y,MAlen,NN,MA);
Z=R_1;

for k=1:variable_num
    [x_kf(:,:,k), R(:,:,:,k)] = SquareRootKalmanFilter2(c(:,:,k),MAlen,NN,MA);
end

for k=1:variable_num
    dZ(k,1,:) = R(1,2,:,k);
end

x(:,1:M) = xx(1:nm-np,1:M);
N2 = nm-np;
dx1(:,1) = (xx(1+np:nm, 1) - xx(1:nm-np, 1)) / (np*dt);

for t = 2:N-1
    a1n_merge(:,:,t) = inv(Z(:,:,t)) * dZ(:,:,t);
    T_1_2(t,1) = (Z(1,2,t)/Z(1,1,t)) * a1n_merge(2,1,t);
 end

% 
T12fan=flipud(abs(T_1_2));
%T12fan=flipud(T_1_2);
cal=MAlen+NN;
dd=T21zheng;
%dd = (T21zheng+T12fan)/2;
dd(1:cal) = T12fan(1:cal);
err90(1:cal-2)=err90(cal-1:2*(cal-2));
err95(1:cal-2)=err95(cal-1:2*(cal-2));
err99(1:cal-2)=err99(cal-1:2*(cal-2));


% T12fan=flipud(abs(T_1_2));
% T21zheng((T21zheng)==0)=nan;
% T12fan((T12fan)==0)=nan;
% T12fan = normalize_loudan(T12fan,T21zheng);
% dd = (T21zheng+T12fan)/2;
% cal=MAlen+NN;
% dd(1:cal) = T12fan(1:cal);
% dd(end-cal:end) = T21zheng(end-cal:end);
% err90(1:cal-2)=err90(cal-1:2*(cal-2));
% err95(1:cal-2)=err95(cal-1:2*(cal-2));
% err99(1:cal-2)=err99(cal-1:2*(cal-2));
