function decompress(compressedImg, method, k, h)
  img = imread(compressedImg);
  [a, l, p] = size(img);
  
  if method == 1 %bilinear

    n = a + (a-1)*k;
    D = expandMatrix(img, n, k);

    for i=1:h:(a-h)
      for j=1:h:(a-h)
        %calcular pontos dados das bordas
        i
        j
        fq00 = img(i, j, :);
        fq10 = img(i+h, j, :);
        fq01 = img(i, j+h, :);
        fq11 = img(i+h, j+h, :); 
    
        A = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h.^2];

        %preencher os pixels criados com a expansao do quadrado
        for s = 1:3
          for p=i:(i+h)
            for r=j:(j+h)
              B = [fq00(s); fq01(s); fq10(s); fq11(s)];
              B = double(B);
              X = linsolve(A, B);
              D(p,r) = X(1,1) + X(2,1)*(p - i) + X(3,1)*(r - j) + X(4,1)*(p - i)*(r - j);
            endfor
          endfor
        endfor
      endfor
    endfor
  endif
  imwrite(D, 'decompress.png');
endfunction

function D = expandMatrix(img, n, k) 
  for i=1:(n-1)
    for j=1:(n-1)
      if(rem(i, k+1) == 1 && rem(j,k+1) == 1)
        D(i,j,:) = img((i-1)/(k+1) + 1, (j-1)/(k+1) + 1, :);
      endif
    endfor
  endfor
endfunction
       