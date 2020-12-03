clc;
clear all;
close all;

Im = imread('boat512.tiff');
if ndims(Im) >= 2
    I = Im(:,:,1);    
end
I = double(I);
[row,col] = size(I);

%Order of the Psuedo Magic Cube
N = 5;

%Rolling Axes
rx = 1; ry = 0; rz = 0;

%Generate the Pseudo Magic Cube of order N
MC = magicCube(N, rx, ry, rz);

% Initialize the seed with an integer between 0 and 2^32-1
seed = randi(2^32)-1;

%Sample secret message generated using random numbers between 1 and N^3
ssz=floor(sqrt(row*col/3));
sz=(ssz*ssz);
msg = randi([1 N^3],1,sz);
%-----------------------------NOTE----------------------------------
%Add 1 to your secret message if its range is between 0 and N^3 - 1
%-------------------------------------------------------------------

%Embedding Phase
steg = embed_mc(I, msg, N, seed,rx,ry,rz);

%Extraction Phase
recover = extract_mc(steg, sz, N, seed, rx, ry, rz);

%Overlaid cover and stego image histograms
h1  = imhist(uint8(I), 255); 
h2 = imhist(uint8(steg),255);
bar(h1,'r');
hold on;
bar(h2,'y')
