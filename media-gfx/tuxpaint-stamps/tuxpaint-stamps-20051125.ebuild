# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint-stamps/tuxpaint-stamps-20051125.ebuild,v 1.4 2007/07/12 04:08:47 mr_bones_ Exp $

inherit eutils

MY_P="${PN}-2005.11.25"
DESCRIPTION="Set of 'Rubber Stamp' images which can be used within Tux Paint."
HOMEPAGE="http://www.newbreedsoftware.com/tuxpaint/"

DEPEND="media-gfx/tuxpaint"

IUSE=""
SRC_URI="mirror://sourceforge/tuxpaint/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"

src_compile() {
	emake || die "Compilation failed"
}

src_install () {
	make PREFIX="${D}/usr" install || die "Installation failed"

	rm -f docs/COPYING.txt
	dodoc docs/*.txt
}
