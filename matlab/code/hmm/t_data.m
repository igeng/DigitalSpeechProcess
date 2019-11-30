%happiness
for i = 1:40
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\happiness\happiness_',num2str(i-1),'.wav');
    [y,fs] = audioread(g);
    y=y';
    j=i;
    eval(['y',num2str(j),'=','y',';']);
end

%sadness
for i = 1:40
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\sadness\sadness_',num2str(i-1),'.wav');
    [y,fs] = audioread(g);
    y=y';
    j=i+40;
    eval(['y',num2str(j),'=','y',';']);
end

%anger
for i = 1:40
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\anger\anger_',num2str(i-1),'.wav');
    [y,fs] = audioread(g);
    y=y';
    j=i+80;
    eval(['y',num2str(j),'=','y',';']);
end

%fear
for i = 1:40
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\fear\fear_',num2str(i-1),'.wav');
    [y,fs] = audioread(g);
    y=y';
    j=i+120;
    eval(['y',num2str(j),'=','y',';']);
end

%neutral
for i = 1:40
    g = strcat('G:\DSP\BerlinSpeech\BerlinWave\wav\neutral\neutral_',num2str(i-1),'.wav');
    [y,fs] = audioread(g);
    y=y';
    j=i+160;
    eval(['y',num2str(j),'=','y',';']);
end

for i = 1:20
    eval(['c1','{',num2str(i),'}','=','y',num2str(i),';']);%h
    eval(['c2','{',num2str(i),'}','=','y',num2str(i+40),';']);%s
    eval(['c3','{',num2str(i),'}','=','y',num2str(i+80),';']);%a
    eval(['c4','{',num2str(i),'}','=','y',num2str(i+120),';']);%f
    eval(['c5','{',num2str(i),'}','=','y',num2str(i+160),';']);%n
end

train_data={c1 c2 c3 c4 c5};
save('train_data.mat','train_data');
