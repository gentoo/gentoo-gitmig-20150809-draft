# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-1.5.5.ebuild,v 1.3 2002/07/23 00:12:55 seemant Exp $

S=${WORKDIR}/quicktime
DESCRIPTION="quicktime library for linux"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND="media-libs/jpeg"

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
