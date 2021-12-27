# Image Processing
Seoul National University of Science and Technology<br />
Department of Electronic and IT Media Engineering<br />
Professor : Byeongkeun Kang<br />
## Context
1. [Image Blending](#1-image_blending)
2. [Histogram Equalization](#2-histogram-equalization)
3. [Gaussian Filtering](#3-gaussian-filtering)
4. [Median Filtering](#4-median-filtering)
5. [Bilinear Interpolation](#5-bilinear-interpolation)
6. [Edge Detection (Sobel operator)](#6-edge-detection-sobel-operator)
7. [Edge Detection (Marr–Hildreth algorithm)](#7-edge-detection-marrhildreth-algorithm)
8. [Feature Matching](#8-feature-matching)
## 1. Image Blending
- Implement a function that creates a composite image from two images, im1 and im2.
- The function has three inputs (im1, im2, α) and one output (result). 
- result = α⋅im1+(1−α)⋅im2!<br />
### im1 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; im2 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result<br />
![imageA](https://user-images.githubusercontent.com/90415099/147421680-bb43e796-0cf9-4db9-94a3-0bacffc4edf3.png)
![imageB](https://user-images.githubusercontent.com/90415099/147421720-89816649-2a6f-44b4-a54d-87e1b20281d3.png)
![result_blend](https://user-images.githubusercontent.com/90415099/147421774-77d2732e-a51c-4e74-9734-e030fcc00311.png)
## 2. Histogram Equalization
- Implement a function that processes histogram equalization.
- The function has two inputs (im, n) and one output (result).
- “n” is the number of levels of the histogram.
### original 
![Unequalized_Hawkes_Bay_NZ](https://user-images.githubusercontent.com/90415099/147421813-e6f11c03-3936-4648-8d59-66ae1d8dfb60.jpg)
### result
![result_histEq](https://user-images.githubusercontent.com/90415099/147421832-0fea70a7-5808-4676-98d9-e2c48e72d0e6.png)
## 3. Gaussian Filtering
- Implement a function that processes Gaussian filtering on an image using a Gaussian filter.
- The function has two inputs (im, σ) and one output (result).
- σ: standard deviation of Gaussian filter
- The size of filter: (2×⌈2σ⌉+1 by 2×⌈2σ⌉+1)
- For boundary region, if a pixel is out of image, assume the pixel has the same intensity with the closest pixel
### original&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result
![Lenna_salt_pepper](https://user-images.githubusercontent.com/90415099/147422098-d0945ac0-37b9-4f90-8370-2a81200de076.png)
![result_GaussianFilter](https://user-images.githubusercontent.com/90415099/147422101-ef9f561f-0a02-478d-8050-c37726fca5c0.png)
## 4. Median Filtering
- Implement a function that processes median filtering on an image.
- The function has two inputs (im, filterSize) and one output (result).
- For boundary region, if a pixel is out of image, assume the pixel has the same intensity with the closest pixel.
### original&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result
![Lenna_salt_pepper](https://user-images.githubusercontent.com/90415099/147422148-1646917c-5ce7-4096-84a3-26ed642d9acf.png)
![result_medianFilter](https://user-images.githubusercontent.com/90415099/147422150-0e3c036f-51a5-404d-a1d1-334593ae8be0.png)
## 5. Bilinear Interpolation
- Implement a function that processes bilinear interpolation to increase the size of an image.
- The function has two inputs (im, scale) and one output (result).
- For elements at right-end and bottom-end, assume the pixel has the same intensity with the closest pixel.
### original
![Lenna](https://user-images.githubusercontent.com/90415099/147422446-abbec39c-cc36-42af-809b-42ee92e4a6e3.png)
### result
![result_bilinearInterpolation](https://user-images.githubusercontent.com/90415099/147422467-48f5bd7f-a5c3-4583-b587-555a3623e894.png)
## 6. Edge Detection (Sobel operator)
- Implement a function that detects edges using Sobel operator on an image.
- The function has one input (im) and one output (result).
- The output of the function should be the magnitude of the gradient of an input image.
- For boundary region, if a pixel is out of image, assume the pixel has the same intensity with the closest pixel.
### original&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sobel Edge Detector
![Lenna](https://user-images.githubusercontent.com/90415099/147422446-abbec39c-cc36-42af-809b-42ee92e4a6e3.png)
![result_SobelEdge](https://user-images.githubusercontent.com/90415099/147422571-0cf6d9f8-5315-4aa3-93e6-ab820e5b235b.png)
### Sobel Edge Detector with Median Filter
![result_SobelEdge_medianFilter](https://user-images.githubusercontent.com/90415099/147422573-8797cdef-b404-4738-96d2-41efd661c019.png)
## 7. Edge Detection (Marr–Hildreth algorithm)
- Implement a function that detects edges using the Marr–Hildreth algorithm on an image.
- The function has three inputs (im, σ, threshold) and one output (result).
- The output of the function should be a binary edge map.
- σ: standard deviation of Gaussian filter.
- threshold: threshold for zero-crossing.
- Size of LoG filter: (2×⌈3σ⌉+1 by 2×⌈3σ⌉+1)
- For boundary region, if a pixel is out of image, assume the pixel has the same intensity with the closest pixel.
### original&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result
![Lenna_salt_pepper](https://user-images.githubusercontent.com/90415099/147422893-4821bffd-7a69-436b-8189-4dbc2952caed.png)
![result_ MarrHildrethEdge](https://user-images.githubusercontent.com/90415099/147422900-a1937a69-8ce0-439d-8ff9-7a073643515e.png)
## 8. Feature Matching
### Orginal Image
![Notre_Dame_1](https://user-images.githubusercontent.com/90415099/147423284-7d80fcc5-c239-4921-ae15-7d41c9b33244.png)
![Notre_Dame_2](https://user-images.githubusercontent.com/90415099/147423285-b08b9c54-e32f-468a-a78c-001c2f02bc5f.png)
### Harris Corner Detector
- Implement a function “detectHarrisCorner” that detects interest points using the Harris corner detection algorithm on an image.
- The function has seven inputs (im, fx_operator, fy_operator, Gaussian_sigma, alpha, C_thres, NMS_ws) and two outputs (corner, C).
- The output “corner” should contain [x, y] coordinates of interest points.
- The output “C” should contain a cornerness score map which has the same size as the input image.
- im: input image.
- fx_operator, fy_operator: vector to use to compute derivatives along x-direction and y-direction.
- Gaussian_sigma: standard deviation of Gaussian filter for filtering squares/products of the derivative maps.
- alpha: for the cornerness score map.
- C_thres: threshold for the cornerness score map.
- NMS_ws: window size for non-maximum suppression.
- Size of Gaussian filter: (2×⌈2σ⌉+1 by 2×⌈2σ⌉+1).
- For boundary region, ignore interest points (in 8 pixels from any boundary).<br />
The cornerness of the two images<br />
![Cornerness_1](https://user-images.githubusercontent.com/90415099/147423188-d54464c6-e048-42bb-a829-4f248067dcc3.jpg)
![Cornerness_2](https://user-images.githubusercontent.com/90415099/147423189-0542c70f-26e8-494c-b599-1fd56346af4a.jpg)<br />
The detected corner of the two images<br />
![CornerDetection_1](https://user-images.githubusercontent.com/90415099/147423242-dd860c21-41cb-4b1f-a89d-444d621f175d.jpg)
![CornerDetection_2](https://user-images.githubusercontent.com/90415099/147423243-3203b303-61e8-41dc-997b-54e9013ea932.jpg)
### SIFT Descriptor
- Implement a function “extractSIFT” that extracts SIFT features using the Scale Invariant Feature Transform (SIFT) algorithm around interest points.
- The function has five inputs (im, fx_operator, fy_operator, corner, Gaussian_sigma) and one output (SIFT).
- The output “SIFT” should contain SIFT features for all “corner” points. (size: # of corner X 128) image.
- im: input image.
- fx_operator, fy_operator: vector to use to compute derivatives along x-direction and y-direction.
- corner: from “detectHarrisCorner”.
- Gaussian_sigma: standard deviation of the Gaussian filter for filtering the magnitude of the gradient.
- Size of Gaussian filter: (16×16).
- For boundary region, ignore interest points (in 8 pixels from any boundary).
### Feature Matching using Distance Ratio
- Implement a function “matchFeatures” that matches SIFT features using the nearest neighbor distance ratio algorithm between two images.
- The function has two inputs (SIFT1, SIFT2) and one output (matching).
- The output “matching” should contain two columns. The first column should contain the index of matched interest points from image 2. The second column should contain distance ratios. (size: # of corners in SIFT1 X 2)
- SIFT1, SIFT2: from “extractSIFT”.
### Result (Distance ratio Threshold=0.5)
![FeatureMatching](https://user-images.githubusercontent.com/90415099/147423368-165501ce-e8c9-4f90-a34a-997f66f3b448.jpg)

### Result (Distance ratio Threshold=0.63)
![그림1](https://user-images.githubusercontent.com/90415099/147423419-8c92a206-5a79-48c9-9167-009abd79f0c6.jpg)
