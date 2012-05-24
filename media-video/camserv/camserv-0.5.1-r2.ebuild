# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camserv/camserv-0.5.1-r2.ebuild,v 1.17 2012/05/24 03:44:58 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A streaming video server"
HOMEPAGE="http://cserv.sourceforge.net"
SRC_URI="mirror://sourceforge/cserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

# libtool's libltdl is used for loading plugins
RDEPEND="media-libs/imlib2
	>=sys-devel/libtool-2.2.6b
	virtual/jpeg"
DEPEND="${RDEPEND}
	media-libs/libv4l" # libv4l1-videodev.h wrt #396635

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO javascript.txt"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P/.1}-errno.patch \
		"${FILESDIR}"/${P}-libtool.patch \
		"${FILESDIR}"/${P}-memcpy.patch

	# no longer existing macro (AM_ACLOCAL_INCLUDE), but we don't need it
	# linux-headers no longer ship videodev.h wrt #396635
	sed -i \
		-e '/AM_ACLOCAL_INCLUDE/d' \
		-e 's:linux/videodev.h:libv4l1-videodev.h:' \
		configure.in camserv/video_v4l.c || die

	AT_M4DIR=macros eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default

	newinitd "${FILESDIR}"/camserv.init camserv

	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
