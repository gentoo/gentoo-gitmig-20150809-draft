# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/chaplin/chaplin-1.10-r1.ebuild,v 1.2 2006/08/30 13:41:34 zzam Exp $

inherit eutils

IUSE="transcode vcd"

S="${WORKDIR}/${PN}"

DESCRIPTION="This is a program to raw copy chapters from a dvd using libdvdread"
HOMEPAGE="http://www.lallafa.de/bp/chaplin.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=media-libs/libdvdread-0.9.4
	>=media-gfx/imagemagick-5.5.7.14
	transcode? ( >=media-video/transcode-0.6.2 )
	vcd? ( >=media-video/vcdimager-0.7.2 )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-libdvdread-0.9.6.patch"
}

src_install() {
	dobin chaplin || die "Failed installing file chaplin"
	dobin chaplin-genmenu || die "Failed installing file chaplin-genmenu"
}
