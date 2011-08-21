# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.12-r1.ebuild,v 1.1 2011/08/21 01:20:16 mattst88 Exp $

EAPI=4

inherit autotools eutils

MY_P=${P}-1

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://mpg321.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="alsa ipv6"

RDEPEND="sys-libs/zlib
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libao[alsa?]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-check-for-lround.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-mpg123-symlink \
		$(use_enable ipv6)
}

src_install() {
	emake DESTDIR="${D}" install
	newdoc debian/changelog ChangeLog.debian
	dodoc AUTHORS BUGS HACKING NEWS README{,.remote} THANKS TODO
}
