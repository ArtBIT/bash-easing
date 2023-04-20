# ft=bash

# EASING FNCTIONS IN BASH

# Easing functions are Surjective Functions and map domain 0..1 to 0..1

# Global BC options, atm only configuring floating math precision
BC_OPTIONS="scale=20;"

# Main ease function
# Usage
#    ease FUNCTION TIME FROM TO

function ease_usage {
cat <<- EOF
NAME

        ease - Ease value using one of the predefined easing methods


SYNOPSIS

        ease METHOD VALUE FROM TO

    To linearly ease a value from 100 to 200:

        ease quad_in_out 0 100 200      - would return the start value 100
        ease quad_in_out 1 100 200      - would return the end value 200
        ease quad_in_out 0.5 100 200    - would return a value between the 100 and 200, which is 150


DESCRIPTION

    METHOD              - The easing method to use

        linear          - linear easing method
        quad_in         - quadratic easing method 
        quad_out        - quadratic easing method
        quad_in_out     - quadratic easing method
        cubic_in        - cubic easing method
        cubic_out       - cubic easing method
        cubic_in_out    - cubic easing method
        quart_in        - quartic easing method
        quart_out       - quartic easing method
        quart_in_out    - quartic easing method
        quint_in        - quintic easing method
        quint_out       - quintic easing method
        quint_in_out    - quintic easing method
        sine_in         - sinusoidal easing method
        sine_out        - sinusoidal easing method
        sine_in_out     - sinusoidal easing method

    VALUE               - float value from a 0..1 range

    FROM                - start value

    TO                  - end value
    
EOF
}
# FUNCTION         - The easing function to use
# To ease a value from 1 to 100
# ease linear_ease_in $percentage 1 100
function ease {
    if [ "$#" -ne 4 ]; then
        ease_usage
        return 1
    fi
    EASING_METHOD="$1"
    shift
    if [[ $(type -t "ease_$EASING_METHOD") == function ]]; then
        k=$(ease_$EASING_METHOD $1)
        math "($3 - $2)*$k + $2"
        return 0
    fi
    echo "Easing function $EASING_METHOD does not exist"
    return 1
}

function xy_echo {
    tput cup $2 $1 
    echo "$3"
}

function ease_debug {
    EASING_METHOD="$1"
    WIDTH=50
    HEIGHT=25
    STEPS=100
    tput clear

    for (( y=0; y<$HEIGHT; y++)); do
        xy_echo 0 $y "|"
    done
    for (( x=0; x<$WIDTH; x++)); do
        xy_echo $x $HEIGHT "-"
    done

    for (( i=1; i<$STEPS; i++)); do
        t=$(math "$i/$STEPS")
        x=$(math "($t*$WIDTH)/1" "scale=0;")
        v=$(ease_$EASING_METHOD $t)
        y=$(math "$HEIGHT-($v*$HEIGHT)/1" "scale=0;")
        xy_echo $x $y "x"
    done

    tput cup $((HEIGHT+2)) 0
}

# Math.pow()
function math {
    OPTIONS=${2:-$BC_OPTIONS}
    #1>&2 echo "$1"
    echo "$OPTIONS $1" | bc -l | sed 's/^\./0./'
}
function pow {
    math "$2^$1"
    #math "e($2*l($1))"
}
function abs {
    echo "${1//-/}"
}

# GENERIC
function ease_in {
    pow "$1" "$2"
}
function ease_out {
    math "1 - $(abs $(math "($2 - 1)^$1"))"
}
function ease_in_out {
    if (( $(bc<<<"$2 < 0.5") )); then
        # map 0..0.5 to 0..1
        t=$(math "$2 * 2")
        # map 0..1 back to 0..0.5
        math "$(ease_in $1 $t)/2"
    else
        # map 0.5..1 to 0..1
        t=$(math "$2 * 2 - 1")
        # map 0..1 back to 0.5..1
        math "$(ease_out $1 $t)/2+0.5"
    fi
}

# LINEAR
function ease_linear {
    echo "$1"
}

# QUADRATIC
function  ease_quad_in {
    ease_in 2 "$1"
}
function  ease_quad_out {
    ease_out 2 "$1"
}
function  ease_quad_in_out {
    ease_in_out 2 "$1"
}

# CUBIC
function  ease_cubic_in {
    ease_in 3 "$1"
}
function  ease_cubic_out {
    ease_out 3 "$1"
}
function  ease_cubic_in_out {
    ease_in_out 3 "$1"
}

# QUARTIC
function  ease_quart_in {
    ease_in 4 "$1"
}
function  ease_quart_out {
    ease_out 4 "$1"
}
function  ease_quart_in_out {
    ease_in_out 4 "$1"
}

# QUINTIC
function  ease_quint_in {
    ease_in 5 "$1"
}
function  ease_quint_out {
    ease_out 5 "$1"
}
function  ease_quint_in_out {
    ease_in_out 5 "$1"
}

# SINUSOIDAL
# PI is 4 * a(1) [ 4 x arctan of 1 ]
function  ease_sine_in {
	math "s($1 * 2*a(1))"
}
function  ease_sine_out {
	math "s((1-$1) * -2*a(1))+1"
}
function  ease_sine_in_out {
    # map 0..1 to -1..1
    t=$(math "$1 * 2 - 1")
    # map -1..1 back to 0..1
	math "(s($t * 2*a(1)) + 1)/2"
}

