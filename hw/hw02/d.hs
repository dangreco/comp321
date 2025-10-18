{-
Counting Stars

Description:
Analyze astronomical images to count the number of stars visible in bitmap
images. Each image consists of pixels represented as either black ('#') or
white ('.'). A star is defined as a connected group of black pixels, where
pixels are considered connected if they are adjacent horizontally or vertically
(not diagonally). Count the total number of distinct stars in each image.

Input Format:
- Multiple test cases until end of file
- Each test case starts with a line containing two integers: m, n (1 ≤ m, n ≤ 100)
- Next m lines contain n characters each, representing the bitmap image
- Characters are either '#' (black pixel, part of star) or '.' (white pixel, empty space)
- Input contains at least one and at most 50 test cases

Output Format:
For each test case, print the case number followed by the number of stars
visible in the corresponding image.
Format: "Case X: Y" where X is case number and Y is star count.

Example:
Input:
10 20
####################
#..................#
#..................#
#..................#
#..................#
#......##..........#
#......##..........#
#..................#
#..................#
####################

Output:
Case 1: 4

Constraints:
- 1 ≤ m, n ≤ 100 (image dimensions)
- At most 50 test cases
- Images contain only '#' and '.' characters
- Stars are connected components of '#' pixels
- Connection is 4-directional (up, down, left, right) only

Notes:
- This is a connected components problem on a 2D grid
- Can be solved using DFS, BFS, or Union-Find algorithms
- For each unvisited '#' pixel, start a new connected component search
- Mark all connected '#' pixels as visited during each search
- Count the number of separate connected components found
-}

main :: IO ()
main = pure ()
