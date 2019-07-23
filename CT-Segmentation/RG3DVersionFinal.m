function [J] = myRegionGrowing32(I, initPos, thresVal, maxNumel)
% REGIONGROWING Region growing algorithm for 2D/3D grayscale images
[nRow, nCol, nSli] = size(I);

% preallocate array
J = false(nRow, nCol, nSli);

J(initPos(1), initPos(2), initPos(3)) = 1;
counter = 1;

% add the initial pixel to the queue
queue = initPos;

%%% START OF REGION GROWING ALGORITHM
while ~isempty(queue) && (counter < maxNumel)
    % the first queue position determines the new values
    xv = queue(1,1);
    yv = queue(1,2);
    zv = queue(1,3);
    
    % .. and delete the first queue position
    queue(1,:) = [];
    
    % check the neighbors for the current position
    for i = -1:1
        for j = -1:1
            for k = -1:1
                
                if xv+i > 0  &&  xv+i <= nRow &&...          % within the x-bounds?
                        yv+j > 0  &&  yv+j <= nCol &&...          % within the y-bounds?
                        zv+k > 0  &&  zv+k <= nSli &&...          % within the z-bounds?
                        any([i, j, k])       &&...      % i/j/k of (0/0/0) is redundant!
                        ~J(xv+i, yv+j, zv+k)           % pixelposition already set?
                    
                    % vecinos
                    nn = 1;
                    neigh_J = J(max(xv+i-nn,1):min(xv+i+nn,nRow),max(yv+j-nn,1):min(yv+j+nn,nCol),max(zv+k-nn,1):min(zv+k+nn,nSli));
                    neigh_cIM = I(max(xv+i-nn,1):min(xv+i+nn,nRow),max(yv+j-nn,1):min(yv+j+nn,nCol),max(zv+k-nn,1):min(zv+k+nn,nSli));
                    
                    neigh_mean = mean(neigh_cIM(neigh_J));
                    neigh_median = median(neigh_cIM(neigh_J));
                    neigh_max = max(neigh_cIM(neigh_J));
                    neigh_min = min(neigh_cIM(neigh_J));
                    %neigh_std =std(neigh_cIM(neigh_J));
                    
%                     % Umbral
%                     %thresVal = adaptthresh(I(:,:,zv+k),0.5,'NeighborhoodSize',[3 3]);
%                      thresVal = 0.5*(neigh_median+(neigh_max-neigh_min)*(1-I(xv+i,yv+j,zv+k)));
                    if I(xv+i, yv+j, zv+k) <= (neigh_mean + thresVal) && I(xv+i, yv+j, zv+k) >= (neigh_mean - thresVal) % within the range of the threshold?
                        % current pixel is true, if all properties are fullfilled
                        J(xv+i, yv+j, zv+k) = true;
                        counter = counter+1;
                        % add the current pixel to the computation queue
                        queue = [queue; xv+i, yv+j, zv+k];
                        
                    end
                end
            end
        end
    end
end
%%% END OF REGION GROWING ALGORITHM



% text output with final number of vertices
disp(['Region Growing Ending: Found ' num2str(nnz(J))...
    ' pixels within the threshold range'])

end