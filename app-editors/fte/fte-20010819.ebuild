# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/fte/fte-20010819.ebuild,v 1.1 2001/09/18 09:40:22 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Lightweight text-mode editor"

SRC_URI="http://prdownloads.sourceforge.net/fte/fte-20010819-src.zip
  	 http://prdownloads.sourceforge.net/fte/fte-20010819-common.zip"

HOMEPAGE="http://fte.sourceforge.net"

DEPEND="virtual/glibc"

TARGETS=""

if [ "`use slang`" ] ; then
    TARGETS="$TARGETS sfte"
fi

if [ "`use X`" ] ; then
    TARGETS="$TARGETS xfte"
fi

if [ "`use gpm`" ] ; then
    TARGETS="$TARGETS vfte"
fi

src_unpack() {

   cd ${WORKDIR}
   unpack fte-20010819-src.zip
   unpack fte-20010819-common.zip

   mv fte fte-20010819

   cd ${S}; patch -p0 < ${FILESDIR}/${PF}-gentoo.diff

   cp src/fte-unix.mak src/fte-unix.mak.orig

   cat src/fte-unix.mak.orig | \
   sed "s/@targets@/${TARGETS}/" | \
   sed "s/@cflags@/${CFLAGS}/" \
   > src/fte-unix.mak
}

src_compile() {
   emake all || die
 
   cd config 
   ../src/cfte main.fte ../src/system.fterc
}

src_install () {
   local files
   into /usr

   files="${TARGETS} cfte compkeys"

   for i in ${files} ; do
      dobin src/$i ;
   done

   dodoc Artistic CHANGES BUGS COPYING HISTORY README TODO 
  
   dodir etc/fte
   cp src/system.fterc ${D}/etc/fte/system.fterc

   dodir usr/share/doc/${P}/html
   cp doc/INDEX doc/*.html ${D}/usr/share/doc/${P}/html

   if [ -a ${D}/usr/bin/xfte ] ; then
      into /usr/X11R6 ;
      dobin src/xfte ;
      rm ${D}/usr/bin/xfte ;
   fi
   
   dodir usr/share/fte
   cp -R config/* ${D}/usr/share/fte
   rm -rf ${D}/usr/share/fte/CVS
}

