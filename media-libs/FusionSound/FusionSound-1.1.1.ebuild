# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/FusionSound/FusionSound-1.1.1.ebuild,v 1.2 2008/04/15 14:51:43 drac Exp $

DESCRIPTION="Audio sub system for multiple applications"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://www.directfb.org/downloads/Core/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vorbis mp3"

RDEPEND=">=dev-libs/DirectFB-${PV}
	vorbis? ( media-libs/libvorbis )
	mp3? ( media-libs/libmad )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}
