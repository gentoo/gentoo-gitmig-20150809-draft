# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-1.5.5.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/quicktime
DESCRIPTION="quicktime library for linux"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"

DEPEND="virtual/glibc media-libs/jpeg"
RDEPEND="virtual/glibc"

src_compile() {
	
	emake || die
	make util || die
}

src_install () {

	dolib.so `uname -m`/libquicktime.so
	dolib.a  `uname -m`/libquicktime.a
	insinto /usr/include/quicktime
	doins *.h
	dodoc README 
	dohtml -r docs
}
