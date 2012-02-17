# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXaw3d/libXaw3d-1.6.1.ebuild,v 1.2 2012/02/17 08:54:14 ssuominen Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="X.Org Xaw3d library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="unicode"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXt"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc
	x11-proto/xextproto
	x11-proto/xproto"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable unicode internationalization)
		)

	xorg-2_pkg_setup
}
