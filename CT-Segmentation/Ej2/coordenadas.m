function [x, y, z] = coordenadas (imagen)
%Para imagenes 3D
w=size(imagen,1); %Dim en x
l=size(imagen,2); %Dim en y
ind = find(imagen~=0);% Cantidad de valores no nulos
l_ind = size(ind);
x = zeros(l_ind);
y = zeros(l_ind);
z = zeros(l_ind);
for i = 1:length(ind)
    z(i) = ceil(ind(i)/(w*l));  
    if rem(ind(i),(w*l))==0
        y(i)=w;
    else
    y(i) = ceil(rem(ind(i),(w*l))/w);
    end
    if rem(rem(ind(i),(w*l)),w)==0
        x(i)=l;
    else
    x(i) = rem(rem(ind(i),(w*l)),l);
    end
end
end