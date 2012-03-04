# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libGLw/libGLw-1.0.0_pre120304.ebuild,v 1.2 2012/03/04 19:50:03 mr_bones_ Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

DESCRIPTION="Mesa GLw library"
HOMEPAGE="http://mesa3d.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+motif static-libs"

RDEPEND="
	!media-libs/mesa[motif]
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/openmotif
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myeconfargs=(
		--enable-motif
		)
	autotools-utils_src_configure
}
