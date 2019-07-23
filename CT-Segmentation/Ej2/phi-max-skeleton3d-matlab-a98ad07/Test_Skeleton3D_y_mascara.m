clear all;
close all;
clc;
%%
A = load_nii('Caso1-mascara.nii');
testval = logical(A.img(:,:,:));
%%
skel = Skeleton3D(testval);
%% Grafico la MÁSCARA
figure(1);
col=[.7 .7 .8];
hiso = patch(isosurface(testval,0),'FaceColor',col,'EdgeColor','none');
hiso2 = patch(isocaps(testval,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(testval,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
%%
hold on;
%% Grafico el ESQUELETIZADO 

w=size(skel,1);
l=size(skel,2);
h=size(skel,3);
[x,y,z]=ind2sub([w,l,h],find(skel(:))); % consigo las coordenadas x y z de la esqueletización
plot3(y,x,z,'square','Markersize',4,'MarkerFaceColor','r','Color','r');            
set(gcf,'Color','white');
view(140,80)

%% Grafico las coordenadas de la máscara
aa=size(testval,1);
bb=size(testval,2);
cc=size(testval,3);                         
[xx,yy,zz]=ind2sub([aa,bb,cc],find(testval(:)));
figure(2)
plot3(yy,xx,zz,'square','Markersize',4,'MarkerFaceColor','r','Color','r'); % consigo las coordenadas xx yy zz de la máscara           
set(gcf,'Color','white');
view(140,80)
%% Distancia euclideana x y z (vía aérea) con respecto a los puntos xx yy zz (máscara)

% Las coordenadas  repetidas en zz corresponden a un anillo. Hay que
% solamente conseguir 1 coordenada en zz y filtrar el resto. Luego hay que
% emparentar este vector zz con sus correspondientes valores en xx e yy. Así
% obtenes las coordenadas de la máscara que vas a querer luego calcular la 
% distancia euclidea con respecto a los puntos esqueletizados de la vía
% aérea

zz_new(1)=zz(1);
for i = 2:length(zz)
    if zz(i)~=zz(i-1)
        zz_new(i) = zz(i);
    end
end
zz_new = zz_new';



    


