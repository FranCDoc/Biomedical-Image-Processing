function [sensibilidad, especificidad, exactitud, dice, jaccard, distjac] = metricas (goldstandard, imagen)
tam = size(goldstandard);
verdaderos = goldstandard==imagen;
falsos = 1-verdaderos;
unos = goldstandard==ones(tam);
ceros = goldstandard==zeros(tam);
coincidencias0 = verdaderos == ceros;
coincidencias1 = verdaderos == unos;
no_ceros = falsos == ceros;
no_unos = falsos == unos;
vp = numel(coincidencias1(coincidencias1==1));
vn = numel(coincidencias0(coincidencias0==1));
fp = numel(no_unos(no_unos==1));
fn = numel(no_ceros(no_ceros==1));
sensibilidad = vp/(vp+fn);
especificidad = vn/(vn+fp);
exactitud = (vp+vn)/(vp+vn+fp+fn);
dice = 2*vp/(2*vp+fn+fp);
jaccard = vp/(vp+fn+fn);
distjac  = 1 - jaccard;
end