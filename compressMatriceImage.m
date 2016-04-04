function matOut = compressMatriceImage(matIn,l,k)

% Transformation par compression d'une matrice [n,m]
% en une matrice [l,k] avec l < n et k < m
% Par défaut, l = k = 8;
% Feuilloy Mathieu - 24/02/2010

% Vérification des arguments
if nargin < 1
    error ('Il manque la matrice image');
end
if (nargin < 2 & max(size(matIn)) > 8)
    l = 8;
    k = 8;
end

ecartLigne = round(size(matIn,1)/l);
ecartColonne = round(size(matIn,2)/k);

% Transformation par compression
ii1 = 0;
matOut = 0*ones(k,l);
for i1=1:ecartLigne:size(matIn,1)-ecartLigne
	ii1 = ii1 +1;
    ii2 = 0;
    for i2=1:ecartColonne:size(matIn,2)-ecartColonne
    	ii2 = ii2 +1;
        matOut(ii1,ii2) = (sum(sum(matIn(i1:i1+ecartLigne-1,i2:i2+ecartColonne-1))));%/(ecartLigne*ecartColonne);
    end
end  