# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-1.0.ebuild,v 1.1 2007/05/25 13:20:35 george Exp $

inherit eutils

DESCRIPTION="gnat module for eselect."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
RDEPEND="app-admin/eselect"

MODULEDIR="/usr/share/eselect/modules"

src_install() {
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	doins ${FILESDIR}/gnat.eselect-${PVR}
	mv ${D}${MODULEDIR}/gnat.eselect-${PVR} ${D}${MODULEDIR}/gnat.eselect
}
