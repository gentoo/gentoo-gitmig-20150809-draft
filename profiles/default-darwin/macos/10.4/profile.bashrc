MACOSX_DEPLOYMENT_TARGET=10.4

# <usata@gentoo.org> (23 Sep 2004)
# /usr/X11R6 is not in our PATH
export PATH="${PATH}:/usr/X11R6/bin"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/X11R6/lib/pkgconfig"                                                                          

alias libtool=glibtool
alias libtoolize=glibtoolize
[ -x /usr/bin/gsed ] && alias sed=gsed
