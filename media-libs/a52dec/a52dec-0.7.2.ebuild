# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.2.ebuild,v 1.2 2002/07/11 06:30:38 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a52dec is a bundle of the liba52 (a free library for decoding ATSC A/52 streams used in DVD, etc) with a test program"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://liba52.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {

  ./configure --prefix=/usr || die
  make || die	

}

src_install() {
	
  make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info docdir=${D}/usr/share/doc/${PF}/html sysconfdir=${D}/etc install || die

  dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO doc/liba52.txt

}

