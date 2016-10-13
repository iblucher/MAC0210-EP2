function err =  calculateError(originalImg, decompressedImg)
   orig = double(imread(originalImg));
   dec = double(imread(decompressedImg));
   
   origR = orig(:,:,1);
   origG = orig(:,:,2);
   origB = orig(:,:,3);
   decR = dec(:,:,1);
   decG = dec(:,:,2);
   decB = dec(:,:,3);
   
   errR = (norm(origR - decR))/norm(origR);
   errG = (norm(origG - decG))/norm(origG);
   errB = (norm(origB - decB))/norm(origB);
   err = (errR + errG + errB)/3;
   disp(err);
endfunction