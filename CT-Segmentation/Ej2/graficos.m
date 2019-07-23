% Grafico la MÁSCARA
figure(1);
col=[.7 .7 .8];
hiso = patch(isosurface(testval,0),'FaceColor',col,'EdgeColor','none');
%hiso2 = patch(isocaps(testval,0),'FaceColor',col,'EdgeColor','none');
axis equal;axis off;
lighting phong;
isonormals(testval,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
%% Grafico el ESQUELETIZADO 
hold on;
[x, y, z] = coordenadas(skel);
plot3(y,x,z,'square','Markersize',1.5,'MarkerFaceColor','r','Color','r');            
set(gcf,'Color','white');
view(140,80)
%% Grafico los vectores
paso=2;
for n= 1:paso:size(diametros,1)
    x_puntos = [diametros(n,2); x(1+(n-1)*10)];
    y_puntos = [diametros(n,3); y(1+(n-1)*10)];
    z_puntos = [diametros(n,4); z(1+(n-1)*10)];
    hold on;
    plot3(y_puntos,x_puntos,z_puntos,'LineStyle','-','MarkerSize',2,'LineWidth',2.75);
end
%% Grafico el contorno
plot3(yy,xx,zz,'square','Markersize',0.5,'MarkerFaceColor','b','Color','b'); 
