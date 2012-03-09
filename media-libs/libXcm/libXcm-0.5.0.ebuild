# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libXcm/libXcm-0.5.0.ebuild,v 1.3 2012/03/09 23:10:50 mr_bones_ Exp $

EAPI=4

inherit eutils

DESCRIPTION="reference implementation of the net-color spec"
HOMEPAGE="http://www.oyranos.org/libxcm/"
SRC_URI="mirror://sourceforge/oyranos/${PN}/${PN}-0.4.x/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc static-libs"

RDEPEND="X? ( x11-libs/libXmu
		x11-libs/libXfixes
		x11-libs/libX11
		x11-proto/xproto )"
DEPEND="${RDEPEND}
	app-doc/doxygen"

pkg_setup() {
	if ! use X ; then
		die "must be build with X support, upstream broken"
	fi
}

#src_prepare() {
#	if ! use X ; then
#		sed -e "/HAVE_X11/s:\"#define HAVE_X11 1\"::" \
#			-e "/PKG_CONFIG_PRIVATE_X11/s:xproto x11::" \
#			-i configure
#	fi
#}

src_configure() {
	econf --disable-silent-rules \
		$(use_enable static-libs static)
}

src_install() {
	default

	use doc && dohtml doc/html/*
}
