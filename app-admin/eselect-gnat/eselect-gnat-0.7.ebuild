# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-0.7.ebuild,v 1.1 2006/05/02 10:18:57 george Exp $

inherit eutils

DESCRIPTION="gnat module for eselect."
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="app-admin/eselect"

MODULEDIR="/usr/share/eselect/modules"

src_install() {
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	doins ${FILESDIR}/gnat.eselect-${PV}
	mv ${D}${MODULEDIR}/gnat.eselect-${PV} ${D}${MODULEDIR}/gnat.eselect
}
