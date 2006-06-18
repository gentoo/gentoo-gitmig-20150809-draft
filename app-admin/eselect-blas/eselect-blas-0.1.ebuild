# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-blas/eselect-blas-0.1.ebuild,v 1.1 2006/06/18 20:59:04 spyderous Exp $

inherit eutils

DESCRIPTION="BLAS module for eselect"
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
	local MODULE="blas"
	dodir ${MODULEDIR}
	insinto ${MODULEDIR}
	newins ${FILESDIR}/${MODULE}.eselect-${PVR} ${MODULE}.eselect
	doman ${FILESDIR}/blas.eselect.5
}
