# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0-r1.ebuild,v 1.7 2006/01/13 18:15:41 gustavoz Exp $

DESCRIPTION="Nuvola SVG icon theme."
SRC_URI="http://www.icon-king.com/files/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"
LICENSE="LGPL-2"

IUSE=""
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
SLOT="0"

RESTRICT="nostrip"

S="${WORKDIR}/nuvola"

# necessary to avoid normal compilation steps, we have nothing to compile here
src_compile() {
	einfo "Nothing to compile..."
}

src_install(){
	cd ${S}

	insinto /usr/share/icons/
	doins -r ${S}
}
