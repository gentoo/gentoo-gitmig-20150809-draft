#!/bin/bash
Big5 () {

    cat /usr/X11R6/share/stardict/hzfont/fonts.dir | \
    sed "s/hz16.pcf/hz16ft.pcf/" > /tmp/fonts.dir
    cp /tmp/fonts.dir /usr/X11R6/share/stardict/hzfont/fonts.dir
    xset fp rehash
}

GB () {
    xset fp rehash
}

echo 
echo 
echo "This is a Chinese / Englist dict for Big5 or GB"
echo 
echo

echo -n "Please chose character-set big5 or gb [big5/gb] : "
read code

case $code in
    big5 )
    echo "Seting for big5"
    Big5
    ;;
    
    gb )
    echo "Seting for gb"
    GB
    ;;
    
    *)
    echo "Seting for big5"
    Big5
    ;;
esac
