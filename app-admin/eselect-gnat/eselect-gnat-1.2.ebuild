# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-gnat/eselect-gnat-1.2.ebuild,v 1.1 2007/12/14 12:13:59 george Exp $

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

# NOTE!!
# This path is duplicated in gnat-eselect module,
# adjust in both locations!
LIBDIR="/usr/share/gnat/lib"

src_install() {
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	newins "${FILESDIR}"/gnat.eselect-${PVR} gnat.eselect
	dodir ${LIBDIR}
	insinto ${LIBDIR}
	newins "${FILESDIR}"/gnat-common-${PWR}.bash gnat-common.bash
}
