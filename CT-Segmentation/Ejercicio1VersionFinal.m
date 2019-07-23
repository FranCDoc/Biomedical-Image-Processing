% clear all;close all;clc
% 
% 
% caso = 5;
% %% Cargo imagen
% char = strcat('Caso',num2str(caso),'.nii');
% charM = strcat('Mascara',num2str(caso),'.nii');
% A = load_nii(char);
% I = double(A.img(:,:,:));
% Amask= load_nii(charM);
% mask = double(Amask.img(:,:,:));
I=I-min(min(min(I)));
I=I./max(max(max(I)));
%% Primer seedpoint manual
Figura = figure;
zseed = round((5/6)*length(I(1,1,:)));
Corte = I(:,:,zseed);
himage = imshow(Corte);
p = ginput(1);
xseed = round(axes2pix(size(Corte, 2), get(himage, 'XData'), p(2)));
yseed = round(axes2pix(size(Corte, 1), get(himage, 'YData'), p(1)));
pos = [xseed yseed zseed]; % seedpoint
close(Figura);

%% Region Growing
Maxpuntos = 150000;
thresVal=0.015;
display('RegionGrowing arranca...ahora');
[J] = myRegionGrowing32(I,pos,thresVal,Maxpuntos);
segmentation_view({J,mask});
display('Terminó RG, graficando...');

%% evaluar que onda
