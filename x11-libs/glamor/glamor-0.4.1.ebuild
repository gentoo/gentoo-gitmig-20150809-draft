# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/glamor/glamor-0.4.1.ebuild,v 1.1 2012/05/01 18:08:10 chithanh Exp $

EAPI=4

XORG_DRI=always
XORG_EAUTORECONF=yes
inherit xorg-2

DESCRIPTION="OpenGL based 2D rendering acceleration library"
SRC_URI="mirror://gentoo/glamor-0.4.1.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="gles"

RDEPEND=">=x11-base/xorg-server-1.10
	media-libs/mesa[egl]
	gles? (
		|| ( media-libs/mesa[gles2] media-libs/mesa[gles] )
	)
	>=x11-libs/pixman-0.21.8"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable gles glamor-gles2)
	)
}

src_prepare() {
	sed -i 's/inst_LTLIBRARIES/lib_LTLIBRARIES/' src/Makefile.am || die
	xorg-2_src_prepare
}
