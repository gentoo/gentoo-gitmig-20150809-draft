# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.30.ebuild,v 1.1 2006/06/02 12:05:05 wolf31o2 Exp $

DESCRIPTION="Gentoo LiveCD tools for autoconfiguration of hardware"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
#KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="opengl X"

OPENGL_DEPEND="virtual/opengl
	|| (
		app-admin/eselect-opengl
		>=x11-base/opengl-update-2.2.1 )"

RDEPEND="dev-util/dialog
	x86? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( sys-apps/pciutils
			x11-misc/mkxf86config
			sys-apps/gawk ) )
	amd64? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( sys-apps/pciutils
			>=x11-misc/mkxf86config-0.9.2
			sys-apps/gawk ) )"

src_install() {
	doinitd autoconfig
	newinitd spind.init spind
	if use x86 || use amd64
	then
		use X && dosbin x-setup && newinitd x-setup.init x-setup
		use opengl && dosbin openglify
	fi
	dosbin net-setup spind
	into /
	dobin bashlogin
	dosbin livecd-functions.sh
}
