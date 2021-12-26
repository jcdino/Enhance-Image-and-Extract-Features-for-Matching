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
