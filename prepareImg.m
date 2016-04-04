function to_guess = prepareImg(name,columnatZero, mu, sigma, coef)
%Format guess
img = imread(name)/255;
img = img(:,:,1);
img = rognageMatImage(img);
imgc = compressMatriceImage(img, 8, 8);
X=feature_extraction_generic(imgc(:)');
%Cleaning up zeroes
X(:,columnatZero)=[];
%Normalization
Xguessnorm = (X - mu)./sigma;
%PCA
to_guess = Xguessnorm/coef';
%%DEBUG
%figure(1)
%subplot 322
%plot(X)
%subplot 324
%plot(Xguessnorm)
%subplot 326
%plot(to_guess)
