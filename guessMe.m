

%% Add Paths
addpath('/Users/Alexis/Documents/MatLab/Digit-Recog/Neural-Network-Digit-Recognition-Matlab/toolbox');

%% 
load('data_set_10_chiffres_APP.mat');
img = reshape(XA(1,:), 32, 32);
Xa = [];
Xt = [];

for j=1:size(XA,1)
    imga = reshape(XA(j,:), 32, 32);
    imgad = double(imga);
    imgac = compressMatriceImage(imgad, 8,8);  
    Xa = [Xa; feature_extraction_generic(imgac(:)')];   
end

Xapp = Xa;
%Cleaning up zeroes
Xclean = sum(Xapp);
columnatZero = find(Xclean'==0);
Xapp(:,columnatZero)=[];

%Normalization
[temp, mu, sigma] = zscore(Xapp);
Xnorm = (Xapp - repmat(mu,967,1))./repmat(sigma,967,1);

%PCA
[coef, temp] = pca(Xnorm);
Xpca = Xnorm/coef';

%Répartition
Xapp = Xpca(1:800,:);
Xtest = Xpca(800:900,:);
TTEMP = TA;
TA = TTEMP(1:800);
TT = TTEMP(800:900);

classes = unique(TA);
nClasses = length(classes);
e=eye(nClasses);
tTA=zeros(size(TA,1),size(e,2));
for i=1:size(TA,1)
    id = find(classes==TA(i));
    tTA(i,:)=[e(id,:)];
end

net = newff(Xapp',tTA',10);
net.trainParam.showWindow=0;
net = train(net,Xapp',tTA');
outputs = sim(net,Xtest');
s=softmax(outputs);
[r t]=max(s);
classesOUT=zeros(size(t,2),1);
for i=1:size(t,2)
    classesOUT(i)=[classes(t(i))];
end
taux_classification = length(find(classesOUT == TT))/length(classesOUT)
