# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/FusionSound/FusionSound-1.0.0.ebuild,v 1.1 2007/08/24 15:36:05 hd_brummy Exp $

inherit eutils

DESCRIPTION="Audio sub system for multiple applications"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://www.directfb.org/downloads/Core/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="vorbis mp3"

DEPEND=">=dev-libs/DirectFB-${PV}
		virtual/libc
		vorbis? ( media-libs/libvorbis )
		mp3? ( media-libs/libmad )"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.12"

src_install() {

	emake install DESTDIR=${D} || die "install failed"
}
