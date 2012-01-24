# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXaw3d/libXaw3d-1.6-r1.ebuild,v 1.3 2012/01/24 19:12:50 ssuominen Exp $

EAPI=4

inherit flag-o-matic xorg-2

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
	append-flags -Wno-error=pointer-to-int-cast

	XORG_CONFIGURE_OPTIONS=(
		$(use_enable unicode internationalization)
		)

	xorg-2_pkg_setup
}

src_prepare() {
	use unicode && \
		sed -i -e 's/Cflags:/& -DXAW_INTERNATIONALIZATION/' xaw3d.pc.in

	xorg-2_src_prepare
}
