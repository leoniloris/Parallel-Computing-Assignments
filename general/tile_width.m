opa4=[];opa8=[];opa16=[];opa32=[];
for i=1:length(opa)
    %1 6 10 50 
    switch opa(i).tile_width
        case '4'
            opa4=[opa4 opa(i)];
        case '8'
            opa8=[opa8 opa(i)];
        case '16'
            opa16=[opa16 opa(i)];
        case '32'
            opa32=[opa32 opa(i)];
    end
end
%%%%%%%%%%%%%%%%%%%%% opa4
hold on,grid on;
Z(1,:)=opa4(1).spdup;Z(2,:)=opa4(2).spdup;Z(3,:)=opa4(3).spdup;Z(4,:)=opa4(4).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile4db','-dpng');close all;

hold on,grid on;
Z(1,:)=opa4(5).spdup;Z(2,:)=opa4(6).spdup;Z(3,:)=opa4(7).spdup;Z(4,:)=opa4(8).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile4fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa8
hold on,grid on;
Z(1,:)=opa8(1).spdup;Z(2,:)=opa8(2).spdup;Z(3,:)=opa8(3).spdup;Z(4,:)=opa8(4).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile8db','-dpng');close all;

hold on,grid on;
Z(1,:)=opa8(5).spdup;Z(2,:)=opa8(6).spdup;Z(3,:)=opa8(7).spdup;Z(4,:)=opa8(8).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile8fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa16
hold on,grid on;
Z(1,:)=opa16(1).spdup;Z(2,:)=opa16(2).spdup;Z(3,:)=opa16(3).spdup;Z(4,:)=opa16(4).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile16db','-dpng');close all;

hold on,grid on;
Z(1,:)=opa16(5).spdup;Z(2,:)=opa16(6).spdup;Z(3,:)=opa16(7).spdup;Z(4,:)=opa16(8).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile16fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa16
hold on,grid on;
Z(1,:)=opa32(1).spdup;Z(2,:)=opa32(2).spdup;Z(3,:)=opa32(3).spdup;Z(4,:)=opa32(4).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile32db','-dpng');close all;

hold on,grid on;
Z(1,:)=opa32(5).spdup;Z(2,:)=opa32(6).spdup;Z(3,:)=opa32(7).spdup;Z(4,:)=opa32(8).spdup;
surf(m_size,[1,10,50,6],Z);view(3);
xlabel('tamanho da matriz');ylabel('nùmero de vezes');zlabel('Speedup');title('Speedup em relação ao sequencial');print('tile32fl','-dpng');close all;
