# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/alevt/alevt-1.6.0-r3.ebuild,v 1.2 2002/07/19 10:47:49 seemant Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="Teletext viewer for X11"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/video/${P}.tar.gz"
HOMEPAGE="http://www.goron.de/~froese/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=media-libs/libpng-1.0.12"
	

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

	use gnome && ( \
		insinto /usr/share/pixmaps
		newins contrib/mini-alevt.xpm alevt.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/alevt.desktop
	)
}
