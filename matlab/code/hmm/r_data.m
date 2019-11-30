%happiness
for i = 41:50
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\happiness\happiness_',num2str(i-1),'.wav');
    [z,fs] = audioread(g);
    z=z';
    j=i-40;
    eval(['z',num2str(j),'=','z',';']);
end

%sadness
for i = 41:50
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\sadness\sadness_',num2str(i-1),'.wav');
    [z,fs] = audioread(g);
    z=z';
    j=i-30;
    eval(['z',num2str(j),'=','z',';']);
end

%anger
for i = 41:50
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\anger\anger_',num2str(i-1),'.wav');
    [z,fs] = audioread(g);
    z=z';
    j=i-20;
    eval(['z',num2str(j),'=','z',';']);
end

%fear
for i = 41:50
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\fear\fear_',num2str(i-1),'.wav');
    [z,fs] = audioread(g);
    z=z';
    j=i-10;
    eval(['z',num2str(j),'=','z',';']);
end

%neutral
for i = 41:50
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\neutral\neutral_',num2str(i-1),'.wav');
    [z,fs] = audioread(g);
    z=z';
    j=i;
    eval(['z',num2str(j),'=','z',';']);
end

for i = 1:10
    eval(['r1','{',num2str(i),'}','=','z',num2str(i),';']);%h
    eval(['r2','{',num2str(i),'}','=','z',num2str(i+10),';']);%s
    eval(['r3','{',num2str(i),'}','=','z',num2str(i+20),';']);%a
    eval(['r4','{',num2str(i),'}','=','z',num2str(i+30),';']);%f
    eval(['r5','{',num2str(i),'}','=','z',num2str(i+40),';']);%n
end

recognition_data = {r1 r2 r3 r4 r5};
save('recog_data.mat','recognition_data');
