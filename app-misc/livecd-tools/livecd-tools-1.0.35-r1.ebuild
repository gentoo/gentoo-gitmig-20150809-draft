# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.35-r1.ebuild,v 1.1 2007/04/03 21:06:38 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Gentoo LiveCD tools for autoconfiguration of hardware"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
#KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="opengl X"

OPENGL_DEPEND="virtual/opengl
	x11-misc/mkxf86config
	|| (
		app-admin/eselect-opengl
		>=x11-base/opengl-update-2.2.1 )"

RDEPEND="dev-util/dialog
	sys-apps/pciutils
	sys-apps/gawk
	alpha? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( >=x11-misc/mkxf86config-0.9.7 ) )
	amd64? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( >=x11-misc/mkxf86config-0.9.2 ) )
	x86? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( x11-misc/mkxf86config ) )
	ppc? ( opengl? ( ${OPENGL_DEPEND} )
		X? ( >=x11-misc/mkxf86config-0.9.7 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-umounts.patch
}

src_install() {
	doinitd autoconfig
	newinitd spind.init spind
	if use x86 || use amd64 || use ppc
	then
		if use opengl
		then
			dosbin x-setup openglify
			newinitd x-setup.init x-setup
		fi
	fi
	dosbin net-setup spind
	into /
	dobin bashlogin
	dosbin livecd-functions.sh
}
