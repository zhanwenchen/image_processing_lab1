%% 1. Image classes

% (a) Load a truecolor image of your choice into a matrix I into Matlab
% using imread.
% Question: What is a truecolor image and is this one?
% Answer: 24-bits images, which is about all images today.
I = imread('pamukkale.jpg');

% Display it and include a copy of it in your lab report.
figure; image(I); truesize;

% What's the image's class?
fprintf("class of I is %s\n", class(I));

% What's its size?
fprintf("size of I is %s\n", mat2str(size(I)));

% How many bands does it have?
fprintf("the number of bands of I is %d\n", size(I, 3));

% Find its minimum and maximum values using
fprintf("min of I is %d\n", min(I(:)));
fprintf("max of I is %d\n", max(I(:)));

% (b) Convert the image into a 64-bit floating-point number array using
% the command
D = double(I);

% and check its class.
fprintf("class of D is %s\n", class(D));

%Find the maximum and minimum values of D.
fprintf("min o D is %d\n", min(D(:)));
fprintf("max of D is %d\n", max(D(:)));

% (c) Now display D using
figure; image(D); truesize;

% What happens? Read the Matlab help pages on images as necessary to
% understand what's going on.
% Answer: White image with some blue. If the class is double,
% Matlab only accepts values <- [0 1].
% Question: Why blue? Not all bands are set to 1 (1 in both blue and green)


% What arithmetic operation must you perform on
% D to make it displayable with image(D)? That is, replace D with an
% arithmetically altered version of D - i.e. D = f(D) where f() s some
% arithmetic operation like multiplicatin or division by a constant. Note
% that as you experiment with this, if you replace D with the wrong thing,
% you will have to execute D = double(I); to get it back.
% Answer:
D = D/255;
figure; image(D); truesize;

% Find the maximum and minimum values of your altered D.
fprintf("min o corrected D is %d\n", min(D(:)));
fprintf("max of corrected D is %d\n", max(D(:)));

fprintf("class of corrected D is %s\n", class(D));
fprintf("size of corrected D is %s\n", mat2str(size(D)));



% (d) Once you are able to run
figure; image(D), truesize;
% and get an image that looks correct, convert D back to 8 bits per pixel by entering

U8 = uint8(D);
figure; image(U8); truesize;


% What do you see?
% Answer: The displayed image seems all black.


% Find the maximum and minimum values of U8.
fprintf("min of U8 is %d\n", min(U8(:)));
fprintf("max of U8 is %d\n", max(U8(:)));

% What has the conversion done?
% Answer: The conversion rounded the floats between 0 and 1 to integers 0
% and 1. The image remains 8-bit (with 3 bands) so Matlab treats it as if
% it were still a color image with a range of (integers) [0, 255]. However,
% 1 looks similar to 0 so that the image looks all black though it isn't.

% Now do this:
figure; image(U8*255); truesize;

% What if any colors do you see?
% Answer: Blue, yellow, black, and a little bit of red.

% Why would a binary image have more colors than just black and white?
% Question: "Why would a binary image" is that what U8 * 255 is?
% Answer: (TODO)

% (e) In your own words, write out a short explanation of the differences
% between images of class uint8 and double.
% (TODO)

% Explain what it takes to convert between the formats without losing the
% intensities in the images.
% (TODO)

%% 2. Loading, displaying, and saving color mapped (aka indexed) images.

% (a) Load chweel_mapped.gif and its color map into a matrix in Matlab.
[gif cmap_gif] = imread('cwheel_mapped.gif');


% Use the class(�) function to determine the type of the image
fprintf("class of gif is %s\n", class(gif));

% Use size(�) to determine its dimensions
% Question: Why is this color even though there's 1 band?
% Answer: Because each matrix location is not a color value but an index in
% the accompanying color map.
fprintf("size of gif is %s\n", mat2str(size(gif)));


% Also, note the file size in bytes of cwheel_mapped.gif. How does this
% compare to the dimensions and file size of cwheel.bmp
% Answer: bmp is 1.4MB, but git is 137KB.

% imread returns two data structures. The first one is a matrix containing
% the image. The second is the image?s color map. Think of the color map
% as a palette of colors arranged in a N � 3 table, where N is the number
% of colors. The value at a pixel in the image is not an intensity, but an
% index into the color map ? the number of the row that contains the color
% vector for that pixel.


% How many colors are in the palette for cwheel_mapped.gif?
% Note: Typically all x-bit images have 256 colors.
fprintf("There are %d colors in the palette for cwheel_mapped.gif\n", size(cmap_gif, 1));

%% (b) Use
figure; image(gif); truesize;
% to display image on the screen.

% Question: Why doesn't Matlab automatically detect the colormap and
% display the colormapped image correctly?
% Answer: Matlab always uses the default colormap. If it's colormap,
% you must specify it.


% What do you see? Describe its appearance.
% Answer: It's desplayed incorrectly - mostly yellow and blue.

% Repeat the commands to get the same image in a new figure window.

% Now use the command to associate with the new figure the color map loaded along with cwheel_mapped.gif.
colormap(cmap_gif); title('gif');

% Now what do you see? How does it compare to the first figure you generated in part 2a?
% Answer: The image is displayed correctly using the colormap compared to
% the gif.




%% (c) Create a new color map, say cmap2, from the old one, cmap, as follows:
temp = mean(cmap_gif,2);
cmap2 = [temp temp temp];


% What did this just do?
% Answer: The first step took the mean among the 3 bands of each color in the palette of the
% image and constructed another palette setting 3 bands to the average color intensity of the original palette.
% If the three bands are the same, it's just grey by definition.


% Select the figure that displays cwheel_mapped.gif to which you did not
% did not apply a color map, and apply the new color map using
colormap(cmap2);

% Now what do you see?
% Answer: The gif has been converted to grayscale.

%% (d) Now you are going to compare the 24-bit image, cwheel.bmp, with its
% color mapped version, cwheel_mapped.gif, displayed with its original
% color map ? the one you loaded along with the image in part 2a.
[bmp cmap_bmp] = imread('cwheel.bmp');

% Describe the differences in appearance between cwheel.bmp and
% cwheel_mapped.gif.
figure; image(bmp); truesize; title('bmp');

% Based on their relative appearances, describe how
% gradual changes in color are implemented (or approximated) by the
% color mapped image.
% Answer: (TODO)

% Like you did in Homework 1, use Matlab ?s native indexing to cut a
% 64 � 64 sub-image out of the original truecolor image. Select a region
% where there is a smooth change in intensity or color.
% Answer: (TODO)

% Explain how you did this. Write down the coordinates you chose. Use the
% Matlab function, imresize(�), to enlarge the small image to 512 � 512.
% Use the nearest neighbor mode. Display the new image in a figure window.
% The individual pixels should be clearly, distinctly visible as squares.
% Use the imwrite(�) function to save the enlarged image as a .bmp file.
% Answer: (TODO)

% Do exactly the same thing with cwheel_mapped.gif using the same image
% coordinates, so that you get exactly the same regions out of both images.
% Save the enlarged region as a BMP image with the original color map from
% cwheel_mapped.gif to include in your report. If the enlarged region of
% the colormapped image is in array J512, then this will save the image
% with the colormap as a .bmp file named cwheel_mapped_detail.bmp:
% Answer: (TODO)
% imwrite(J512,cmap,?cwheel_mapped_detail.bmp?,?bmp?);

% (e) It may appear that the color mapped image is inferior to the
% truecolor version. That is usually so for images that are color
% photographs. But if the image is a graphic with no more than the number
% of colors that can be displayed with an indexed image then the indexed
% (color mapped) version may be better, depending on the file format in
% which it is stored.


% The following image illustrates another situation in which a color mapping
% can be useful. Down- load plume_gs.bmp from Blackboard, read and display it
% and its color map in Matlab . This image of a smoke plume is such that the
% intensity (grayscale) of the image at a pixel is directly proportional to the
% density of the smoke at the corresponding location in space. Display the
% image in two other figure windows so that you have three copies of it. Apply
% the the color map you loaded with the image to one of figures. Apply the
% jet(256) color map to the second figure. Can you see structures in the plume
% that were not visible before? If so, describe them. Apply a random color map
% rand(256,3) to the third figure. Repeat colormap(rand(256,3)) a few times
% until you get an image with good contrast. Again, can you see structures that
% were not before visible?

plume = imread('plume_gs.bmp');
% Save the smoke plume image with the jet(256) color map and save it with the
% random color map for inclusion in your report.

% 3. Arithmetic operations on images and sub-images.
% (a) Acquire a 24-bit image about the same size as cwheel.bmp that has a wide
% range of intensities (dark to light). Use an image of your choice, but not
% cwheel.bmp.

merzouga = imread('ZhanwenChenMerzouga.JPG');

% (b) Assume matrix J contains your image. 

% Display (i) J/2, 
figure; image(merzouga/2); truesize;
% Answer: Darker.

% Display (ii) J*2, 
figure; image(merzouga*2); truesize;
% Answer: Way too bright.

% Display (iii) J-128, 
figure; image(merzouga-128); truesize;
% Answer: Darker. No bright.

% and (iv) J+128. 
figure; image(merzouga+128); truesize;
% Answer: Brighter. No dark.

% Describe the results. (You may if you want, 
% but you do not have to include these four images in your report.) What 
% happens when the image is of class uint8, and the result of arithmetic 
% on a pixel would yield a negative value? What happens when the result is 
% greater than 255?
% Answer: (TODO).


% (c) If your image has different dimensions from cwheel.bmp, cut out 
% pieces of one or both images (using native Matlab indexing) so that 
% sthey are both have exactly the same dimensions.

%  Now read cwheel.bmp into variable S in Matlab. 
S = imread('cwheel.bmp');

% Form and display the sum, J+S, 
summed = merzouga+S;
figure; image(summed); truesize;
% Answer: because int8 is [0 255]. 256 is truncated to 255.

% and the product,J.* S. (Note the ?.*?. 
% How is that different from ?*??) Describe the results.
figure; image(merzouga.*S); truesize;
% Answer: (TODO).


% What is the maximum possible value of a sum of two images? How might 
% you adjust the sum so that the maximum fits in an 8-bit image?
fprintf("max(summed(:)) = %d", max(summed(:)));
% Answer: (TODO). Max is 310, which would be truncated. Can shrink
% range? Alternatively, convert to 16 and then convert back to uint8?

% What is the maximum possible value of a product of two images? How 
% might you adjust the product so that the maximum fits in an 8-bit image?
% Answer: 255*255 = 65536. Convert to 16 and then convert back?

%% 4. Looping in Matlab
% If you are not familiar with Matlab functions, then please read the help 
% pages for ?function,? in ?MATLAB > Programming Scripts and Functions > 
% Functions > Function Basics.?

% Matlab provides a way to time the execution of its code, the pair of 
% functions, tic and toc. They are placed in a function before and after 
% the code to be timed. For example

% J = DivIbyConstLoops(I,c)
%    tic
%    % code to time goes here
%     toc 
% end

%% (a) Write a function that divides every pixel in the image by a 
% constant c using loops. That is use for statements to make 3 nested 
% loops. For example, have the the first loop index the bands. Inside 
% that loop index across the columns. And inside that, loop down the rows. 
% Any permutation of the order is OK but there need to be three loops. 
% Note that in the function before the loops you will need to use the size 
% function to get the dimensions of the image.

% Place tic on a line before the first for statement. Place toc on a line 
% after all three loops (the last of 3 end statements). Load an image and 
% run the function on it. Note the elapsed time.
merz_divided_loop = DivIbyConstLoops(merzouga, 2); % 0.043690 seconds.
merz_divided_matmul = DivIbyConstNoLoops(merzouga, 2); % 0.001388 seconds.
function divved = DivIbyConstLoops(image, constant)
    tic
    [nrows, ncols, nbands] = size(image);
    for r = 1:nrows
        for c = 1:ncols
            for b = 1:nbands
                image(r, c, b) = uint8(double(image(r, c, b))/constant);
            end
        end
    end
    toc
    divved = image;
end

%% (b) Write a function that divides every pixel in the image by a 
% constant c without using loops. This is particularly simple,
function J = DivIbyConstNoLoops(I,c)
    tic
    J=uint8(double(I)/c);
    toc
end
% (Note the type conversions.) Load an image and run the function on it. 
% Note the elapsed time. 

% What do the 2 times tell you about using loops in matlab?
% Answer: Matlab is optimized for vectorized operations instead of loops.


%% 5(a) Vectorization

%% 5(a)(i) Write a function that outputs an image J made from input image 
% I such that J(r,c,b) is the average of I(r,c,b) and the 8 pixels that 
% surround it. Use three nested loops, over the bands, the rows, and the columns.


% In the function, record the size of I in the three scalars R, C, and B. 
% Convert I to double. Allocate J as a zero image the same size as I. Loop 
% over all B bands. So as not to go outside of I when constructing J, loop 
% the rows from 2 to R-1 and the columns from 2 to C-1. That means the 
% resulting J will have a 1-pixel wide band of zeros around it. Convert J 
% to uint8.

% See getAverageImage.m

% How long it it take?
% loop: 0.021786 seconds.
% vec: 0.083131 seconds.

%% 5(a)(ii)  Now here is where vectorization comes into play. This entire 
% function can be written as one line of code ? simple Matlab code using
% only [], /, and indexing. Write a second function that uses the one-line 
% solution. Put tic and toc around the line in the function. Run the function on the same image as in the previous section and note the elapsed time. By what factor is the second function faster than the first? Include the numbers and your code, but not the images in your report.
