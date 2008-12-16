# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-boost/eselect-boost-0.1.ebuild,v 1.1 2008/12/16 16:21:07 dev-zero Exp $

inherit multilib

DESCRIPTION="boost module for eselect"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.0.5"

src_install() {
	local mdir="/usr/share/eselect/modules"
	dodir ${mdir}
	sed -e "s|%LIBDIR%|$(get_libdir)|g" "${FILESDIR}/boost.eselect-${PVR}" > "${D}${mdir}/boost.eselect" || die "failed to install"
}
