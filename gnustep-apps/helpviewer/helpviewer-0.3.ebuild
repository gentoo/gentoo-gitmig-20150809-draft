# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/helpviewer/helpviewer-0.3.ebuild,v 1.1 2004/07/23 13:19:51 fafhrd Exp $

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
