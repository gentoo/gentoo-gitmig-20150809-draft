# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-3.0.0.ebuild,v 1.4 2005/08/24 18:04:10 eradicator Exp $

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-admin/eselect-opengl"

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die
}

pkg_postinst() {
	einfo "opengl-update is deprecated and will eventually be removed from portage."
	einfo "The opengl-update executable just calls the opengl eselect module."
}
