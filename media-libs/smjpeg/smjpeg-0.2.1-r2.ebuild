# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smjpeg/smjpeg-0.2.1-r2.ebuild,v 1.13 2004/03/19 07:56:05 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SDL Motion JPEG Library"
SRC_URI="ftp://ftp.linuxgames.com/loki/open-source/smjpeg/${P}.tar.gz"
HOMEPAGE="http://www.lokigames.com/development/smjpeg.php3"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=media-libs/libsdl-1.1.7"

src_compile() {
	use nas && LDFLAGS="-L/usr/X11R6/lib -lXt"

	LDFLAGS="${LDFLAGS}" \
		econf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING README TODO SMJPEG.txt

}
