function [gxx,gxy,gyy] = gaussian2nd2d(s) 

%% grid coordinates
[x,y]   = ndgrid(-round(3*s):round(3*s));

%% Gaussian 2nd derivatives
gxx = 1/(2*pi*s^4) * (x.^2/s^2 - 1) .* exp(-(x.^2 + y.^2)/(2*s^2));
gxy = 1/(2*pi*s^6) * (x .* y)       .* exp(-(x.^2 + y.^2)/(2*s^2));
gyy = gxx';

end