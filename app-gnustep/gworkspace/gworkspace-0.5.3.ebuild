# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gworkspace/gworkspace-0.5.3.ebuild,v 1.1 2003/07/15 08:09:24 raker Exp $

inherit gnustep

S=${WORKDIR}/GWorkspace-${PV}

DESCRIPTION="GNUstep GUI interface designer"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://www.gnustep.it/enrico/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_install() {
	egnustepinstall
	cd ${S}/Apps_wrappers
	cp -a * ${D}${GNUSTEP_SYSTEM_ROOT}/Applications
}
