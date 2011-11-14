# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minidlna/minidlna-1.0.22.ebuild,v 1.3 2011/11/14 01:48:33 xmw Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
HOMEPAGE="http://minidlna.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-db/sqlite
	media-libs/flac
	media-libs/libexif
	media-libs/libid3tag
	media-libs/libogg
	media-libs/libvorbis
	virtual/ffmpeg
	virtual/jpeg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.18-Makefile.patch
}

src_configure() {
	./genconfig.sh || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	dodoc README TODO
}
