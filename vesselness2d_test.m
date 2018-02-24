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

[imv,v] = vesselness2d(im,sigma,gamma,beta,c,wb);

%% plot
figure; imagesc(im); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

figure; imagesc(imv); colormap gray; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;