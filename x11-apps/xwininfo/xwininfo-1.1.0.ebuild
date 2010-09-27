# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xwininfo/xwininfo-1.1.0.ebuild,v 1.1 2010/09/27 12:59:32 scarabeus Exp $

EAPI=3
XORG_STATIC=no
inherit xorg-2

DESCRIPTION="window information utility for X"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND=">=x11-libs/libxcb-1.6
	x11-libs/libX11
	x11-libs/xcb-util
	>=x11-proto/xproto-7.0.17"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PV}-build.patch" )

pkg_setup() {
	CONFIGURE_OPTIONS="--with-xcb-icccm"
	xorg-2_pkg_setup
}
