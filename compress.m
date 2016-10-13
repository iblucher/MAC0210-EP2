function compress (originalImg, k)
  img = originalImg;
  [a, l, p] = size(img);
  
  j = 0;
  img = img(1:(k+1):a, 1:(k+1):l,:);
  imwrite(img, 'compress.png');
endfunction