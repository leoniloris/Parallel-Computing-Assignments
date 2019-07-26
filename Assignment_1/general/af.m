clear all,close all, clc
m_size=[8 16 32 64 128 256 512 1024];
files = [dir('db*') ;dir('fl*')];opa=[];
for i=1:length(files)
    A=textread(files(i).name);
    s1=strsplit(files(i).name,'_');
    pr=s1{1};
    s1=strsplit(s1{2} ,'-');
    opa = [opa struct('spdup',A(:,1)./A(:,2),'tile_width',s1(1),'n_loop',s1(2),'prec',pr)];
end
%% numero de loops cada
run 'n_loop.m'
%% tile_width cada
run 'tile_width.m'
