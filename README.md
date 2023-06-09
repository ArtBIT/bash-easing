# bash-easing
[![Build Status](https://travis-ci.org/ArtBIT/bash-easing.svg)](https://travis-ci.org/ArtBIT/bash-easing) [![GitHub license](https://img.shields.io/github/license/ArtBIT/bash-easing.svg)](https://github.com/ArtBIT/bash-easing) [![GitHub stars](https://img.shields.io/github/stars/ArtBIT/bash-easing.svg)](https://github.com/ArtBIT/bash-easing)  [![awesomeness](https://img.shields.io/badge/awesomeness-maximum-red.svg)](https://github.com/ArtBIT/bash-easing)

Simple exponential easing functions written in bash + bc

# Demo

<a href="https://asciinema.org/a/LfF5iCkuhzhlDRGd07W6yJmCq"><img src="https://raw.githubusercontent.com/ArtBIT/bash-easing/master/assets/poster.png" width="200" /></a>

# Installation

## Manually
```
git clone https://github.com/ArtBIT/bash-easing.git
source path/to/bash-easing/easing.bash
```

## Using [bash-clam](https://github.com/ArtBIT/bash-clam)
```
clam install ArtBIT/bash-easing && clam source ArtBIT/bash-easing/easing.bash
```

# Usage

## Examples

```bash
General usage:

ease METHOD VALUE FROM TO

To linearly ease a value from 100 to 200:

ease linear 0 100 200           - would return the start value 100
ease linear 1 100 200           - would return the end value 200
ease linear 0.5 100 200         - would return a value between the 100 and 200, which is 150

ease quad_in_out 0 100 200      - would return the start value 100
ease quad_in_out 1 100 200      - would return the end value 200
ease quad_in_out 0.1 100 200    - would return 102
ease quad_in_out 0.2 100 200    - would return 108
ease quad_in_out 0.3 100 200    - would return 118
ease quad_in_out 0.5 100 200    - would return 150 (all in_out methods, for VALUE 0.5, return arithmetic mean of FROM,TO - (FROM+TO)/2)
```

## Testing

To do a rough plot of a easing method, run the following
```bash
ease_debug METHOD

# i.e.
ease_debug quad_in
ease_debug quint_out
# etc.
```


# License

[MIT](LICENSE.md)
