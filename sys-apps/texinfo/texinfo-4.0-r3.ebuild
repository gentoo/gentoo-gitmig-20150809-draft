# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.0-r3.ebuild,v 1.3 2001/09/01 07:56:16 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNU info program and utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/texinfo/${A}
	 ftp://ftp.gnu.org/pub/gnu/texinfo/${A}"

if [ "`use build`" ] ; then
  DEPEND="virtual/glibc"
else
  DEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2 nls? ( sys-devel/gettext )"
  RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2-r2"
fi

src_unpack() {
    unpack ${A}
    if [ "`use build`" ] ; then
      cd ${S}
      patch -p0 < ${FILESDIR}/${PF}-no-ncurses-gentoo.diff
      touch *
    fi
}

src_compile() {
    local myconf
    if [ -z "`use nls`" ] || [ "`use build`" ] ; then
        myconf="--disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/usr  ${myconf} \
        --mandir=/usr/share/man --infodir=/usr/share/info
    try make ${MAKEOPTS} 
}

src_install() {

    if [ "`use build`" ] ; then
      dobin makeinfo/makeinfo util/{install-info,texi2dvi,texindex}
    else
      try make DESTDIR=${D} infodir=${D}/usr/share/info install
      exeinto /usr/sbin
      doexe ${FILESDIR}/mkinfodir

      cd ${D}/usr/share/info
      mv texinfo texinfo.info
      for i in texinfo-*
      do
 	mv ${i} texinfo.info-${i#texinfo-*}
      done

      cd ${S}

      dodoc AUTHORS ChangeLog COPYING INTRODUCTION NEWS README TODO 
      docinto info
      dodoc info/README
      docinto makeinfo
      dodoc makeinfo/README
    fi
}






