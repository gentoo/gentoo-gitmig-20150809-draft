# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjackasyn/libjackasyn-0.10.ebuild,v 1.8 2004/10/07 07:04:44 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="An application/library for connecting OSS apps to Jackit."
HOMEPAGE="http://gige.xdv.org/soft/libjackasyn"
SRC_URI="http://devel.demudi.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="media-sound/jack-audio-connection-kit
	media-libs/libsamplerate"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-destdir.patch
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/$(get_libdir)
	dodir /usr/include

	make DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGELOG WORKING TODO
}
