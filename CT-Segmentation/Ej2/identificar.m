function [cx, cy, cz] = identificar(skel)
dimx=size(skel,1);
dimy=size(skel,2);
dimz=size(skel,3);

%% Primer punto
primer_ind=find(skel,1,'last');
semilla = zeros(dimx,dimy,dimz);
semilla(primer_ind)=1;
[cx, cy, cz] = coordenadas(semilla);

%% Voy chequeando vecinos, para continuar el recorrido de la esqueletización
%dir = [0 0 1]; %vector de dirección inicial, se mueve uno hacia arriba en z (comienzo a recorrer la tráquea)
% dirx = dir(1);
% diry=dir(2);
% dirz=dir(3);

cola=[];
colaVieja=[];
etiqueta1=1;
final = zeros(dimx,dimy,dimz);
% Lleno la cola con el primer vecino del seed
boolean = zeros(dimx, dimy, dimz);
 for i=cx-1:cx+1
            for j=cy-1:cy+1 
                for k=cz-1:cz+1
                    if(boolean(i,j,k)==0)
                     if skel(i,j,k)==1
                       final(i,j,k)=etiqueta;
                       colaVieja=[colaVieja; i j k];
                     end
                    end
                   boolean(i,j,k)=1;
                end
            end
 end
        
lcola=length(colaVieja(:,1));

%recorro todos los vecinos

while lcola~=0    
    for p=1:length(colaVieja(:,1))
        voxel=colaVieja(p,:);
        for i=voxel(1)-1:voxel(1)+1
            for j=voxel(2)-1:voxel(2)+1
                for k=voxel(3)-1:voxel(3)+1
                if(boolean(i,j)==0)
                     if skel(i,j,k)==1
                            final(i,j,k)=etiqueta;
                            cola=[cola; i j k]; 
                            
                            if angulo > 30
                                etiqueta=etiqueta+1;
                            end
                     end
                end
                boolean(i,j,k)=1;
                end
            end
        end   
    end   
        lcola=length(cola);
        colaVieja=cola;
        cola=[];   
end

end

% si esta prendido, siguiente punto de la esqueletizacion
% angulo recorriendo
% en 3 direcciones
% maximo, nueva rama
% semilla a la cola
% puntos_ramas = 0;
% end
