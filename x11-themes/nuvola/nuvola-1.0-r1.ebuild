# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0-r1.ebuild,v 1.12 2006/11/28 00:28:32 flameeyes Exp $

DESCRIPTION="Nuvola SVG icon theme."
SRC_URI="http://www.icon-king.com/files/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"
LICENSE="LGPL-2"

IUSE=""
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"

RESTRICT="strip binchecks"

S="${WORKDIR}"

src_install(){
	cd nuvola
	dodoc thanks.to readme.txt author license.txt
	rm thanks.to thanks.to~ readme.txt author license.txt

	cd "${S}"
	insinto /usr/share/icons
	doins -r nuvola
}
