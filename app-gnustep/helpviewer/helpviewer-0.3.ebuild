# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/helpviewer/helpviewer-0.3.ebuild,v 1.5 2004/07/22 21:42:50 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/HelpViewer-${PV}

DESCRIPTION="HelpViewer is an online help viewer for GNUstep programs."
HOMEPAGE="http://www.roard.com/helpviewer/"
SRC_URI="http://www.roard.com/helpviewer/download/HelpViewer-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_unpack() {
	unpack HelpViewer-${PV}.tgz
	cd ${S}
}
