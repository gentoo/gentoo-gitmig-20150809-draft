# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.10.6.ebuild,v 1.11 2009/12/15 12:02:08 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://packages.debian.org/mpg321"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa -mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa"

RDEPEND="sys-libs/zlib
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libao[alsa?]"
DEPEND="${RDEPEND}"

src_prepare() {
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-mpg123-symlink
}

src_install() {
	emake DESTDIR="${D}" install || die
	newdoc debian/changelog ChangeLog.debian
	dodoc AUTHORS BUGS HACKING NEWS README{,.remote} THANKS TODO
}
