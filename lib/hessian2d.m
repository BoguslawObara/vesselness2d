function [hxx,hxy,hyy] = hessian2d(im,s)

%% Gaussian 2nd derivatives
[gxx,gxy,gyy] = gaussian2nd2d(s);

%% Hessian
hxx = imfilter(im,gxx,'conv','same','replicate');
hxy = imfilter(im,gxy,'conv','same','replicate');
hyy = imfilter(im,gyy,'conv','same','replicate');

end