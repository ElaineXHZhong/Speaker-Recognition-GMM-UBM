function data = read_feature(file)

%     assert(exist(file))
    [x,fs] = audioread(file); 
    % x - speech signal
    % fs - sample rate in Hz
%     assert(fs == 16000);

    premcoef = 0.97; % ����Ԥ����ϵ��
    rand ("seed", 1);
%     x = rm_dc_n_dither(x, fs); 
%     x = filter([1 -premcoef], 1, x);

    v = vadsohn(x,fs);
    x = x(v==1);
    fL = 100.0/fs;   % �Ͷ��˲���
    fH = 8000.0/fs;  % �߶��˲���
    fRate = 0.010 * fs; 
    fSize = 0.025 * fs; 
    nChan = 27;  % ��������Ƶ�׵�Ƶ������
    nCeps = 12;  % ����ȡ����MFCC��ϵ���ĸ���

    data = melcepst(x, fs, '0dD', nCeps, nChan, fSize, fRate, fL, fH);
    data = cmvn(data', true);
end
