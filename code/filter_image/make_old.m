function out_img = make_old(img)

I = double(img);
out_img = double(img);
out_img(:,:,1) = 0.4 * I(:,:,1) + 0.8 * I(:,:,2) + 0.2 * I(:,:,3);
out_img(:,:,2) = 0.3 * I(:,:,1) + 0.7 * I(:,:,2) + 0.2 * I(:,:,3);
out_img(:,:,3) = 0.3 * I(:,:,1) + 0.5 * I(:,:,2) + 0.1 * I(:,:,3);
end