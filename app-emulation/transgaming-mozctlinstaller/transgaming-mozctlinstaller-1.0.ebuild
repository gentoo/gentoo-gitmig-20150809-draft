# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/transgaming-mozctlinstaller/transgaming-mozctlinstaller-1.0.ebuild,v 1.2 2009/07/07 23:18:11 flameeyes Exp $

DESCRIPTION="Mozilla ActiveX control for Cedega"
HOMEPAGE="http://www.transgaming.com/"
SRC_URI="${P}-1.i386.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="fetch"

DEPEND="app-emulation/cedega"

pkg_nofetch() {
	elog "Please download the appropriate Cedega archive (${A})"
	elog "from ${HOMEPAGE} (requires a Transgaming subscription)"
	elog ""
	elog "Then put the file in ${DISTDIR}"
}

src_install() {
	mv "${WORKDIR}"/usr "${D}"
}
