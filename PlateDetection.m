im = imread('Number Plate Images/image3.png');
subplot(4,2,1);
imshow(im);
ipp(im,2);

im2=imrotate(im,90);
subplot(4,2,3);
imshow(im2);
ipp(im2,4);

im3=imrotate(im2,90);
subplot(4,2,5);
imshow(im3);
ipp(im3,6);

im4=imrotate(im3,90);
subplot(4,2,7);
imshow(im4);
ipp(im4,8);

function ipp(image,pos)
    imgray = rgb2gray(image);
    imbin = imbinarize(imgray);
    image = edge(imgray, 'prewitt');
    
   properties=regionprops(image,'BoundingBox','Area', 'Image');
    area = properties.Area;
    count = numel(properties);
    maxa= area;
    boundingBox = properties.BoundingBox;
    for i=1:count
       if maxa<properties(i).Area
           maxa=properties(i).Area;
           boundingBox=properties(i).BoundingBox;
       end
    end    
    
    image = imcrop(imbin, boundingBox);
    image = bwareaopen(~image, 500);
    
     [h, w] = size(image);
   % imshow(image);
    
    properties=regionprops(image,'BoundingBox','Area', 'Image');
    count = numel(properties);
    noPlate=[];
    
    for i=1:count
       ow = length(properties(i).Image(1,:));
       oh = length(properties(i).Image(:,1));
       if ow<(h/2) & oh>(h/3)
           letter=LetterDetection(properties(i).Image); 
           noPlate=[noPlate letter];
       end
    end
    noPlate
end