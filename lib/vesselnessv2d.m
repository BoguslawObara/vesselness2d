function [imv,v,vidx,vx,vy,l1,l2] = vesselnessv2d(im,sigma,gamma,beta,c,wb )
%%  vesselnessv2d - multiscale vessel enhancement filtering with vectors
%   
%   REFERENCE:
%       B. Obara, M. Fricker, D. Gavaghan and V. Grau, 
%       Contrast-independent curvilinear structure detection in biomedical 
%       images, IEEE Transactions on Image Processing, 21, 5, 2572-2581, 2012, 
%
%   INPUT:
%       im      - 2D gray image
%       sigma   - Gaussian kernel sigma [1 2 3 ...]
%       gamma   - vesselness threshold parameter
%       beta    - vesselness threshold parameter
%       c       - vesselness threshold parameter
%       wb      - detect black or white regions
%
%   OUTPUT:
%       imv     - vesselness
%       v       - all vesselness images for each sigma
%
%   AUTHOR:
%       Boguslaw Obara
%

%% default parameters
if isempty(sigma);  sigma = 1;  end
if isempty(gamma);  gamma = 2;  end
if isempty(beta);   beta = 0.5; end
if isempty(c);      c = 15;     end
if isempty(wb);     wb = true;  end

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));

%% convert image to grey-scale
im = im2uint8(im); % I assume that Vesselness was defined for grey-scale images

%% convert image to double
im = double(im);

%% start loop over scales
[m,n] = size(im);
v = zeros(m,n,length(sigma)); 
vxt = zeros(m,n,length(sigma)); 
vyt = zeros(m,n,length(sigma));
vx = zeros(m,n); 
vy = zeros(m,n);

for i=1:length(sigma)
    
    % second derivatives - hessian
    [hxx,hxy,hyy] = hessian2d(im,sigma(i));
    
    % normalized derivative - scale
    hxx = power(sigma(i),gamma)*hxx;
    hxy = power(sigma(i),gamma)*hxy;
    hyy = power(sigma(i),gamma)*hyy;
    
    % eigen values and vectors
    %[l1,l2] = eigen2d(hxx,hxy,hxy,hyy);
    [l1,l2,v1,v2] = eigen2d_m(hxx,hxy,hxy,hyy);
    vxt(:,:,i) = v1; vyt(:,:,i) = v2;
    l2(l2==0) = eps;
    
    %% vesselnes
    rbeta = l1./l2;
    s = sqrt(l1.^2 + l2.^2);     
    vo = exp(-(rbeta.^2)/(2*beta^2)).*(ones(size(im))-exp(-(s.^2)/(2*c^2)));  

    % if |l2 > 0| or |l2 < 0|  => vo = 0
    if(wb)
        vo(l2<0) = 0;
    else
        vo(l2>0) = 0;
    end
    
    %% vo for each scale
    v(:,:,i) = vo;
    
end

%% calculate maximum over the scales
if length(sigma)>1
    [imv,vidx] = max(v,[],3);
    for i=1:m
        for j=1:n
            vx(i,j) = vxt(i,j,vidx(i,j)); 
            vy(i,j) = vyt(i,j,vidx(i,j));
        end
    end
else
    imv = v;
    vidx = ones(size(imv));
    vx = vxt(:,:,1); 
    vy = vyt(:,:,1);
end

end
