# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/transgaming-mozctlinstaller/transgaming-mozctlinstaller-1.0.ebuild,v 1.1 2005/01/12 00:10:25 vapier Exp $

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
	einfo "Please download the appropriate Cedega archive (${A})"
	einfo "from ${HOMEPAGE} (requires a Transgaming subscription)"
	einfo ""
	einfo "Then put the file in ${DISTDIR}"
}

src_install() {
	mv "${WORKDIR}"/usr "${D}"
}
