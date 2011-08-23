# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minidlna/minidlna-1.0.21.ebuild,v 1.2 2011/08/23 06:32:28 flameeyes Exp $

EAPI=2

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

src_compile() {
	# bug #350985
	emake -j1 CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die

	dodoc README TODO || die
}
