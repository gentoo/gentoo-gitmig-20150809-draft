# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/chaplin/chaplin-1.10.ebuild,v 1.1 2004/10/06 20:16:11 trapni Exp $

DESCRIPTION="This is a program to raw copy chapters from a dvd using libdvdread"
HOMEPAGE="http://www.lallafa.de/bp/chaplin.html"
SRC_URI="http://www.lallafa.de/bp/files/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="vcdimager transcode"

DEPEND="
	>=libdvdread-0.9.4
	>=imagemagick-5.5.7.14
	transcode? ( >=transcode-0.6.2 )
	vcdimager? ( >=vcdimager-0.7.2 )
"

MY_S="${WORKDIR}/chaplin"

src_compile() {
	cd ${MY_S} || die
	emake || die
}

src_install() {
	dobin ${MY_S}/chaplin || die
	dobin ${MY_S}/chaplin-genmenu || die
}
