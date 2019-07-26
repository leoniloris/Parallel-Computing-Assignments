opa1=[];opa6=[];opa10=[];opa50=[];
for i=1:length(opa)
    %1 6 10 50 
    switch opa(i).n_loop
        case '1'
            opa1=[opa1 opa(i)];
        case '6'
            opa6=[opa6 opa(i)];
        case '10'
            opa10=[opa10 opa(i)];
        case '50'
            opa50=[opa50 opa(i)];
    end
end
%%%%%%%%%%%%%%%%%%%%% opa50
hold on,grid on;
plot(m_size,opa50(1).spdup,'c');
plot(m_size,opa50(2).spdup,'m');
plot(m_size,opa50(3).spdup,'g');
plot(m_size,opa50(4).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('50db','-dpng');close all;

hold on,grid on;
plot(m_size,opa50(5).spdup,'c');
plot(m_size,opa50(6).spdup,'m');
plot(m_size,opa50(7).spdup,'g');
plot(m_size,opa50(8).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('50fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa10
hold on,grid on;
plot(m_size,opa10(1).spdup,'c');
plot(m_size,opa10(2).spdup,'m');
plot(m_size,opa10(3).spdup,'g');
plot(m_size,opa10(4).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('10db','-dpng');close all;

hold on,grid on;
plot(m_size,opa10(5).spdup,'c');
plot(m_size,opa10(6).spdup,'m');
plot(m_size,opa10(7).spdup,'g');
plot(m_size,opa10(8).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('10fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa6
hold on,grid on;
plot(m_size,opa6(1).spdup,'c');
plot(m_size,opa6(2).spdup,'m');
plot(m_size,opa6(3).spdup,'g');
plot(m_size,opa6(4).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('6db','-dpng');close all;

hold on,grid on;
plot(m_size,opa6(5).spdup,'c');
plot(m_size,opa6(6).spdup,'m');
plot(m_size,opa6(7).spdup,'g');
plot(m_size,opa6(8).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('6fl','-dpng');close all;
%%%%%%%%%%%%%%%%%%%%%% opa1
hold on,grid on;
plot(m_size,opa1(1).spdup,'c');
plot(m_size,opa1(2).spdup,'m');
plot(m_size,opa1(3).spdup,'g');
plot(m_size,opa1(4).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('1db','-dpng');close all;

hold on,grid on;
plot(m_size,opa1(5).spdup,'c');
plot(m_size,opa1(6).spdup,'m');
plot(m_size,opa1(7).spdup,'g');
plot(m_size,opa1(8).spdup,'b');
xlabel('tamanho da matriz');xlabel('Speedup');legend('16','32','4','8');title('Speedup em relação ao sequencial');print('1fl','-dpng');close all;
