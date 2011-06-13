# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/frei0r-plugins/frei0r-plugins-1.1.22-r2.ebuild,v 1.1 2011/06/13 18:42:49 ssuominen Exp $

EAPI=4
inherit autotools eutils multilib

DESCRIPTION="A minimalistic plugin API for video effects"
HOMEPAGE="http://www.piksel.org/frei0r/"
SRC_URI="http://propirate.net/frei0r/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE="doc facedetect scale0tilt"

DEPEND="facedetect? ( >=media-libs/opencv-2.2.0 )
	scale0tilt? ( media-libs/gavl )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-opencv-2.2.0-api.patch
	epatch "${FILESDIR}"/${P}-no-automagic-deps.patch
	epatch "${FILESDIR}"/${P}-libdir.patch
	epatch "${FILESDIR}"/${P}-pkgconfig-support.patch   # needed by media-libs/mlt
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable facedetect) \
		$(use_enable scale0tilt) \
		--libdir=/usr/$(get_libdir)
}

src_install() {
	default
	use doc && dohtml -r doc/html
}
