# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.0-r2.ebuild,v 1.1 2002/07/03 17:00:36 seemant Exp $ 

S=${WORKDIR}/${P}

DESCRIPTION="Teletext viewer for X11"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz"
HOMEPAGE="http://www.goron.de/~froese/"
SLOT="0"

DEPEND="virtual/glibc
	>=media-libs/libpng-1.0.12
	>=x11-base/xfree-4.0.1"

LICENSE="GPL-2"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${WORKDIR}

	# Parallel make patch
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff

}

src_compile() {
	
	emake || die

}

src_install () {

	dobin alevt alevt-cap alevt-date
	doman alevt.1x alevt-date.1 alevt-cap.1
	dodoc CHANGELOG COPYRIGHT README
}
