MtvLK-MATLAB toolbox for the computation of Multivariate time-varying Liang-Kleeman information flow

Main functions:
-multiLK_code.m: computes the information flow between multivariate time series 

External functions:
-toymodel1.m: generate time series for synthetic model1
-toymodel2.m: generate time series for synthetic model2
-SquareRootKalmanFilter2.m: the square root Kalman filter based on the Bierman-Thornton algorithm
-bierman.m, thornton.m, EMWA.m, UWMA.m, myUD.m, StandardCovEst.m: these code are used to implement SquareRootKalmanFilter2.m

Scripts:
-multiLK-toymodel1.m: realizes simulation studies a (synthetic model1)
-multiLK-toymodel2.m: realizes simulation studies b (synthetic model2)
-multiLK_huabeirealtest.m: realizes application to Huabei region
-multiLK_huananrealtest.m: realizes application to Huanan region

Data:
-toymodel1.mat: time series of synthetic model1
-toymodel2.mat: time series of synthetic model2
-huabei.mat: climatological time series of Huabei region
-huanan.mat: climatological time series of Huanan region