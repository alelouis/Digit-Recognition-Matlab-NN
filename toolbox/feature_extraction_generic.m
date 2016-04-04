function [feature_vector] = feature_extraction_generic(Input)

taille = size(Input,2);
intervalle = sqrt(taille);

feature_vector=[];
for i=1:size(Input,1)

    % Création de la matrice de l'image
    mat=[];
    for k=1:intervalle:taille
        mat=[mat;Input(i,k:k+intervalle-1)];

    end
    if i==1
        mm=mat;
    end
	    % Extraction des histogrammes
    
    % horizontale
    hist_h = sum(mat);
    
    % verticale
    hist_v = sum(mat');
    
    % diagonale à pi/4
    mat_sym = fliplr(mat);
    hist_pi_4 = [];
    for k=-intervalle+1:1:intervalle-1
        hist_pi_4 = [hist_pi_4 sum(diag(mat_sym,k))];
    end
    % diagonale à -pi/4
    hist__pi_4 = [];
    for k=-intervalle+1:1:intervalle-1
        hist__pi_4 = [hist__pi_4 sum(diag(mat,k))];
    end
    
    % 4 cadrans
    hist_4_cad = [sum(sum(mat(1:intervalle/2,1:intervalle/2))) sum(sum(mat(intervalle/2+1:intervalle,1:intervalle/2))) sum(sum(mat(intervalle/2+1:intervalle,1:intervalle/2))) sum(sum(mat(intervalle/2+1:intervalle,intervalle/2+1:intervalle)))];
    
    % cible
    cible=[];
    step = intervalle/2/4;
    lg1{1} = [1:step];
    lg1{2} = [intervalle-step+1:intervalle];
    lg2{1} = [step+1:2*step];
    lg2{2} = [intervalle-2*step+1:intervalle-step+1-1];
    lg3{1} = [2*step+1:3*step];
    lg3{2} = [intervalle-3*step+1:intervalle-2*step+1-1];
    lg4{1} = [3*step+1:4*step];
    lg4{2} = [intervalle-4*step+1:intervalle-3*step+1-1];
    
    a1  = [sum(sum(mat(lg1{1},:)))+sum(sum(mat(lg1{2},:)))+sum(sum(mat([lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}],lg1{1})))+sum(sum(mat([lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}],lg1{2})))];
    a2  = [sum(sum(mat(lg2{1},[lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}])))+sum(sum(mat(lg2{2},[lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}])))+sum(sum(mat([lg3{1} lg3{2} lg4{1} lg4{2}],lg2{1})))+sum(sum(mat([lg3{1} lg3{2} lg4{1} lg4{2}],lg2{2})))];
    a3  = [sum(sum(mat(lg3{1},[lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}])))+sum(sum(mat(lg3{2},[lg2{1} lg2{2} lg3{1} lg3{2} lg4{1} lg4{2}])))+sum(sum(mat([lg3{1} lg3{2} lg4{1} lg4{2},lg3{1}])))+sum(sum(mat([lg3{1} lg3{2} lg4{1} lg4{2}],lg3{2})))];
    a4  = [sum(sum(mat(lg4{1}:lg4{2},lg4{1}:lg4{2})))];
    cible=[a1  a2  a3 a4];
   
    % rapport de bits actifs
    bit_actif = (sum(sum(mat)))/(1024);
    
	feature_vector = [feature_vector;hist_h hist_v hist_pi_4 hist__pi_4 hist_4_cad cible bit_actif];
end
