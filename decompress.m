function decompress(compressedImg, method, k, h)
  img = imread(compressedImg);
  [a, l, p] = size(img);
  
  if method == 1 %bilinear

    n = a + (a-1)*k;
    D = expandMatrix(img, n, k);

    for i=1:h:(n-1)
      for j=1:h:(n-1)
        %calcular pontos dados das bordas
        fq00 = img(i, j, :);
        fq10 = img(i+h, j, :);
        fq01 = img(i, j+h, :);
        fq11 = img(i+h, j+h, :); 
        
        x = i;
        y = j;
        z = i+h;
        w = j+h;
    
        A = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h.^2];

        %preencher os pixels criados com a expansao do quadrado
        for p=(x:z)
          for r=(y:w) 
            %obter tres matrizes dos canais RGB da imagem comprimida
            for s = 1:3
              B = [fq00(s); fq01(s); fq10(s); fq11(s)];
                
            
          endfor
        endfor
     endfor
   endfor 
        
    
  else %bicubic
endfunction

function D = expandMatrix(img, n, k) {
  for i=1:n
      for j=1:n
        if(img(i, k+1) == 1 && img(j, k+1) == 1)
          D(i,j) = img((i-1)/(k+1) + 1, (j-1)/(k+1) + 1, :);
  }

       