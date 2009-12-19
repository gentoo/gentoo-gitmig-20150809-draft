# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.11.ebuild,v 1.1 2009/12/19 13:40:09 ssuominen Exp $

EAPI=2

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://mpg321.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa -mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa ipv6"

DEPEND="sys-libs/zlib
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libao[alsa?]"

S=${WORKDIR}/${PN}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-mpg123-symlink \
		$(use_enable ipv6)
}

src_install() {
	emake DESTDIR="${D}" install || die
	newdoc debian/changelog ChangeLog.debian
	dodoc AUTHORS BUGS HACKING NEWS README{,.remote} THANKS TODO
}
