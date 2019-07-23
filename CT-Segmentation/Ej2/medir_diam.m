function diametros = medir_diam (imagen)
close all;clc;
%% El archivo de imagen debe ser ingresado de la forma 'CasoN.nii' con las
%comillas
A = load_nii(imagen);
%% Esqueletización
se = strel('sphere',1);
dilatedmask = imdilate(A.img,se);
testval = logical(dilatedmask(:,:,:));
skel = Skeleton3D(testval);
[x, y, z]=coordenadas(skel);
%% Busco contorno
contorno=dilatedmask-A.img;
 [xx,yy,zz]=coordenadas(contorno);
% MIN. DISTANCE
% puntos_ramas=identificar(skel);
% x=puntos_ramas(:,1);
% y=puntos_ramas(:,2);
% z=puntos_ramas(:,3);
Q = [x,y,z]; 
P = [xx,yy,zz];
paso=10;
sQ = size(Q,1);
diametros = zeros(floor(sQ/paso),4);
sP = size(P,1);
cont = 1;
for q = 1:paso:sQ
    distancia_ant = 100000000000000;
    for p=1:sP % Calculo las distancias de todos los puntos de P a uno de Q
    distancia = sqrt(sum(((Q(q,:)-P(p,:)).*[0.7031 0.7031 0.6]).^2)); % Las distancias se convierten a milimetros
    if distancia < distancia_ant
        minQ = distancia;
        punto_minimo = P(p,:);
        distancia_ant = distancia;
    end
    end
    diametros(cont,1)=2*minQ; %Se convierte el radio a diámetro
    diametros(cont,2:4)=punto_minimo;
    cont = cont + 1;
end
end