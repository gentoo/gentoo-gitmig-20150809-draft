# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/Tulliana/Tulliana-2.0.ebuild,v 1.2 2006/06/15 14:11:50 genstef Exp $

DESCRIPTION="Tulliana icon set for KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=38757"
SRC_URI="http://cekirdek.pardus.org.tr/~caglar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dodir /usr/share/icons
	cp -R "${S}" "${D}/usr/share/icons/${PN}"
}

