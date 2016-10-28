  function decompress(compressedImg, method, k, h)
  img = imread(compressedImg);
  [a, l, p] = size(img);
  a
  
  if method == 1 %bilinear
    n = a + (a-1)*k;
    n
    D = expandMatrix(img, n, k);

    for color=1:3
      for i=1:(k+1):(n-(k+1))
        for j=1:(k+1):(n-(k+1))
        %calcular pontos dados das bordas
        fq00 = D(i, j, color);
        fq10 = D(i+(k+1), j, color);
        fq01 = D(i, j+(k+1), color);
        fq11 = D(i+(k+1), j+(k+1), color);
         
        A = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h.^2];
        A_inv = inv(A);

        %preencher os pixels criados com a expansao do quadrado
        B = [fq00; fq01; fq10; fq11];
        B = double(B);
        X = A_inv*B;
          for p=i:(i+(k+1))
            for r=j:(j+(k+1))
              D(p,r, color) = X(1,1) + X(2,1)*((p-i)/(k+1))*h + X(3,1)*((r-j)/(k+1))*h + X(4,1)*(((p-i)/(k+1))*h)*(((r-j)/(k+1))*h);
            endfor
          endfor
        endfor
      endfor
    endfor
  endif
  imwrite(D, 'decompress.png');
endfunction

function D = expandMatrix(img, n, k) 
  for i=1:n
    for j=1:n
      if(rem(i, k+1) == 1 && rem(j,k+1) == 1)
        D(i,j,:) = img((i-1)/(k+1) + 1, (j-1)/(k+1) + 1, :);
      endif
    endfor
  endfor
  size(D)(1)
endfunction
       