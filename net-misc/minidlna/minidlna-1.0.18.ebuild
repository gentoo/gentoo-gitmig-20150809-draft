# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minidlna/minidlna-1.0.18.ebuild,v 1.1 2010/12/29 16:59:25 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
HOMEPAGE="http://minidlna.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND="dev-db/sqlite
	media-libs/flac
	media-libs/libexif
	media-libs/libid3tag
	media-libs/libogg
	media-libs/libvorbis
	media-video/ffmpeg
	virtual/jpeg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake PREFIX="${D}" install || die
	
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die

	dodoc README TODO || die
}
