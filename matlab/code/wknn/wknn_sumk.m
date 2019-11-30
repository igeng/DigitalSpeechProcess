load wksumk1
load wksumk2
load wksumk3
load wksumk4
load wksumk5
load knn_k

wksumk=zeros(50,25);
wksumk=wksumk1+wksumk2+wksumk3+wksumk4+wksumk5;
wksumk=wksumk./5;
wknn_k = sum(wksumk,2);
[kk,ii]=max(wknn_k)

wk_k_nn=wknn_k-knn_k;

figure(2);
x=1:1:50;
ylim([0,1]);
wknn_k=wknn_k./5;
knn_k=knn_k./5;
plot(x,wknn_k,'-*r',x,knn_k,'--ok');


[kkk,iii]=max(wk_k_nn)
figure(3);
x=1:1:50;
plot(x,wk_k_nn,'-.k');