function decompress(compressedImg, method, k)
  img = imread(compressedImg);
  [a, l, p] = size(img);
  
  %obter tres matrizes dos canais RGB da imagem comprimida
  imgR = img(:,:,1);
  imgG = img(:,:,2);
  imgB = img(:,:,3);
  
  if method == 1: %bilinear
    for i=1:a
      for j=1:a
        %calcular pontos dados das bordas
        fq00 = imgR(i, j);
        fq10 = imgR(i+1, j);
        fq01 = imgR(i, j+1);
        fq11 = imgR(i+1, j+1); 
        
        %expandir quadrado com os limites acima para um quadrado (k+2)x(k+2) e 
        %colocar as pontas do novo quadrado iguais as do antigo
        S = zeros(k+2, k+2);
        S(i, j) = fq00;
        S(i, j+k+2) = fq01;
        S(i+k+2, j) = fq10;
        S(i+k+2, j+k+2) = fq11;
        
        %fazer conta do pdf do enunciado para achar os coeficientes a0, a1, a2 e a3
        A = [1, 1, 1, 1;
        i, i, i+(k+2), i+(k+2);
        j, j+(k+2), j, j+(k+2);
        i*j, i*(j+(k+2)), (i+(k+2))*j, (i+(k+2))*(j+(k+2))];
        B = [fq00; fq01; fq10; fq11];
        X = linsolve(A,B);
        
        %preencher os pixels criados com a expansao do quadrado
        for k=(2:(k+1)
          for l=2:(k+1)
            S(k,l) = X(1,1)+X(2,1)*k+X(3,1)*l+X(4,1)*k*l;
          endfor
        endfor
     endfor
   endfor 
        
    
  else %bicubic
endfunction

       