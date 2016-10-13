function compress (originalImg, k)
  img = originalImg;
  [a, l, p] = size(img);
  
  j = 0;
  for i=1:a
    if (mod(i, k+1) == 1)
      img(i-j,:,:) = [];
      img(:,i-j,:) = [];
      j++;
    endif
  endfor
  imwrite(img, 'res.tiff');
endfunction