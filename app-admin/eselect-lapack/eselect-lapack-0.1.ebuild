# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-lapack/eselect-lapack-0.1.ebuild,v 1.1 2006/06/18 21:06:09 spyderous Exp $

inherit eutils

DESCRIPTION="LAPACK module for eselect"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""
# Need skel.bash lib
#RDEPEND=">=app-admin/eselect-1.0.3"
RDEPEND="app-admin/eselect"
DEPEND="${RDEPEND}"

src_install() {
	local MODULEDIR="/usr/share/eselect/modules"
	local MODULE="lapack"
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	newins ${FILESDIR}/${MODULE}.eselect-${PVR} ${MODULE}.eselect
	doman ${FILESDIR}/lapack.eselect.5
}
