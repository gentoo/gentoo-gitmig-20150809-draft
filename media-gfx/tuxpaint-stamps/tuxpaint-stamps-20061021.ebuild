# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint-stamps/tuxpaint-stamps-20061021.ebuild,v 1.2 2007/03/25 20:18:46 ticho Exp $

MY_P="${PN}-2006.10.21"
DESCRIPTION="Set of 'Rubber Stamp' images which can be used within Tux Paint."
HOMEPAGE="http://www.tuxpaint.org/"

DEPEND="media-gfx/tuxpaint"

IUSE=""
SRC_URI="mirror://sourceforge/tuxpaint/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"


src_install () {
	make PREFIX="${D}/usr" install-all || die "Installation failed"

	rm -f docs/COPYING.txt
	dodoc docs/*.txt
}
