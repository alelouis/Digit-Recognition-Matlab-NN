function mat = rognageMatImage(mat)

% Rognage de l'image afin de la centrer et de la normaliser
%
% Feuilloy Mathieu - 24/02/2010


%% Elimination des bords

[n,m] = size(mat);

id0 = find(sum(mat,2)==0); % évaluation des lignes étant égales à 0

mat(id0,:)=[];
%mat(1,:)=[];

add_0=ceil(size(mat,1)/32)*32-size(mat,1);

if rem(add_0,2) == 0
    mat=[zeros(round(add_0/2),size(mat,2));mat;zeros(round(add_0/2),size(mat,2))];
else %rem(add_0,2) ~= 0
    mat=[zeros(fix(add_0/2)+1,size(mat,2));mat;zeros(fix(add_0/2),size(mat,2))];
end

[n,m] = size(mat);

id0 = find(sum(mat,1)==0); % évaluation des colonnes étant égales à 0
mat(:,id0)=[];

add_0=ceil(size(mat,1)/32)*32-size(mat,2);

if rem(add_0,2) == 0
    mat=[zeros(size(mat,1),round(add_0/2)) mat zeros(size(mat,1),round(add_0/2))];
else %rem(add_0,2) ~= 0
    mat=[zeros(size(mat,1),fix(add_0/2)+1) mat zeros(size(mat,1),fix(add_0/2))];
end