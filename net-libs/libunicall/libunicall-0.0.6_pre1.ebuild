# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libunicall/libunicall-0.0.6_pre1.ebuild,v 1.1 2008/12/15 09:58:30 pva Exp $

inherit eutils autotools

DESCRIPTION="An abstration layer for telephony signalling"
HOMEPAGE="http://www.soft-switch.org/"
SRC_URI="http://www.soft-switch.org/downloads/unicall/${PN}-${PV/_}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/audiofile-0.2.6-r1
	>=media-libs/spandsp-0.0.2_pre26
	>=media-libs/tiff-3.8.2-r2"

S=${WORKDIR}/${PN}-${PV/_pre*}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-expose-internal-headers.patch"
	epatch "${FILESDIR}/${P}--as-needed.2.patch"
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS INSTALL NEWS README || die
}
