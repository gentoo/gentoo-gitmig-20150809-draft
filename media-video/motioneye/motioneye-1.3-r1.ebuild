# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motioneye/motioneye-1.3-r1.ebuild,v 1.4 2007/11/27 12:04:16 zzam Exp $

inherit eutils

DESCRIPTION="ppm, jpeg or mjpeg grabber for the MotionEye camera on Sony VAIO Picturebooks."
HOMEPAGE="http://popies.net/meye/"
SRC_URI="http://popies.net/meye/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
RDEPEND="X? ( x11-libs/libX11
			media-libs/imlib )"

DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	X? ( x11-proto/xextproto )
	app-text/docbook-sgml-utils"

src_compile() {
	if use X; then
		export WITHX='yes'
	else
		export WITHX='no'
	fi
	emake WITH_X="${WITHX}" CFLAGS="${CFLAGS}" || die
}

src_install() {
	exeinto /usr/bin
	doexe motioneye
}
