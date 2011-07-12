# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/i3/i3-3e_p3.ebuild,v 1.1 2011/07/12 13:06:07 xarthisius Exp $

EAPI=4

inherit base versionator toolchain-funcs

MY_PV=$(version_format_string '$1.$2-${3/p/bf}')
MY_P=${PN}-${MY_PV}

DESCRIPTION="An improved dynamic tiling window manager"
HOMEPAGE="http://i3wm.org/"
SRC_URI="http://i3wm.org/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/libev
	dev-libs/yajl
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/xcb-util"
DEPEND="${CDEPEND}
	sys-devel/flex
	sys-devel/bison
	x11-proto/xcb-proto"
RDEPEND="${CDEPEND}
	x11-apps/xmessage"

S=${WORKDIR}/${MY_P}

DOCS=( GOALS TODO RELEASE-NOTES-${MY_PV} )
PATCHES=( "${FILESDIR}"/${PN}-gentoo.diff )

pkg_setup() {
	tc-export CC
}

src_install() {
	base_src_install
	doman man/*.1
	dohtml -r docs/*
}

pkg_postinst() {
	elog "${PN} by default uses x11-terms/rxvt-unicode as a default terminal."
	elog "Either merge it yourself or change proper bind in /etc/${PN}/config"
	elog "or ~/.i3/config"
}
