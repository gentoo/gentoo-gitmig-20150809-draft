# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vcr/vcr-1.10.ebuild,v 1.2 2003/09/03 03:14:30 vapier Exp $

DESCRIPTION="VCR - Linux Console VCR"
HOMEPAGE="http://www.stack.nl/~brama/vcr/"
SRC_URI="http://www.stack.nl/~brama/${PN}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-video/avifile-0.7.37*"

src_compile() {
	econf || die "econf died"
	make || die "emake died"
}

src_install () {
	make install DESTDIR=${D} || die "einstall died"
	dodoc AUTHORS ChangeLog NEWS README
}
