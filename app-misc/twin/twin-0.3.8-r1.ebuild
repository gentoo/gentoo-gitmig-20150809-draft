# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A text-mode window environment"
SRC_URI="http://ftp1.sourceforge.net/twin/${A}
	 http://linuz.sns.it/~max/twin/${A}"
HOMEPAGE="http://linuz.sns.it/~max/twin/" 
DEPEND="virtual/glibc
	X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-1.9 )
        >=sys-libs/ncurses-5.2"
	
src_unpack() {
   unpack ${A}
   cd ${S}
   try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
   local conf
   conf="\n\n\n\n\n""\n\n\n\n\n""\n\ny\n\n\n""\n\n\n\n"
   if [ "`use X`" ]
   then
      conf=${conf}"y\n"
   else
      conf=${conf}"n\n"
   fi
   conf=${conf}"\n\n"
   if [ "`use ggi`" ]
   then
      conf=${conf}"y\n"
   else
      conf=${conf}"n\n"
   fi
   conf=${conf}"\n\n""\n\n\n\nn\n" 
   echo -e "${conf}" > test
   try cat test | make config
   rm test
   try make clean
   try make 
}

src_install() {
   
   dodir /usr/lib /usr/bin /usr/lib/ /usr/include /usr/include/Tw \
         /usr/lib/twin/modules /usr/X11R6/lib/X11/fonts/misc

   DESTDIR=${D} make install

   if [ "`use X`" ]
   then
      insinto /usr/X11R6/lib/X11/fonts/misc
         doins fonts/vga.pcf.gz
   fi

}

pkg_postinst() {   
   if [ "`use X`" ]
   then
      /usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
      /usr/X11R6/bin/xset fp rehash
   fi
}

pkg_postrm() {
   if [ "`use X`" ]
   then
      /usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
      /usr/X11R6/bin/xset fp rehash
   fi
}
