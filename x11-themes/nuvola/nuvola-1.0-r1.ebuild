# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0-r1.ebuild,v 1.1 2005/02/23 17:09:38 greg_g Exp $

DESCRIPTION="Nuvola SVG icon theme."
SRC_URI="http://www.icon-king.com/files/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"
LICENSE="LGPL-2"

IUSE=""
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"
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
