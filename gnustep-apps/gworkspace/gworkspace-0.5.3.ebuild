# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gworkspace/gworkspace-0.5.3.ebuild,v 1.2 2004/07/23 14:58:41 fafhrd Exp $

inherit gnustep-old

S=${WORKDIR}/GWorkspace-${PV}

DESCRIPTION="GNUstep workspace manager"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://www.gnustep.it/enrico/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=gnustep-base/gnustep-gui-0.8.5"
IUSE=""

src_install() {
	egnustepinstall
	cd ${S}/Apps_wrappers
	cp -a * ${D}${GNUSTEP_SYSTEM_ROOT}/Applications
}
