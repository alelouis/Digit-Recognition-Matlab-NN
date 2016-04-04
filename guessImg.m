function s = guessImg(X,net,classes)
outputs = sim(net,X');
s=softmax(outputs);
figure(10)
bar(0:9,outputs)
[r t]=max(s);
classesOUT=zeros(size(t,2),1);
for i=1:size(t,2)
   classesOUT(i)=[classes(t(i))];
end
classesOUT