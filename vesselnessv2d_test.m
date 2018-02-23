%% clear
clc; clear all; close all;

%% path
addpath('./lib')

%% load image
im = imread ('./im/jellyfish.png');

%% vesselness
sigma = 0.2:0.5:5; 
gamma = 2; 
beta = 0.5; 
c = 15; 
wb = true;

[v,vmax,vidx,vx,vy,l1,l2] = vesselnessv2d(im,sigma,gamma,beta,c,wb);

%% plot
figure;
subplot(1,2,1), imagesc(im); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;
subplot(1,2,2), imagesc(vmax); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

%% plot
figure;
[x,y] = meshgrid(1:size(im,2),1:size(im,1));
imagesc(vmax); hold on; quiver(x,y,vmax.*vy,vmax.*vx,'r'); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;
set(gca,'xlim',[250 280]); set(gca,'ylim',[220 250])