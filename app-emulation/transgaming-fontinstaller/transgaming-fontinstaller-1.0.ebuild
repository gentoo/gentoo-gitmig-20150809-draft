# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/transgaming-fontinstaller/transgaming-fontinstaller-1.0.ebuild,v 1.2 2004/06/14 08:26:02 kloeri Exp $

DESCRIPTION="font installer for WineX"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${P}.tgz"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-emulation/winex-transgaming"

pkg_nofetch() {
	einfo "Please download the appropriate WineX archive (${A})"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	einfo ""
	einfo "Then put the file in ${DISTDIR}"
}

src_install() {
	mv ${WORKDIR}/usr ${D}
}
