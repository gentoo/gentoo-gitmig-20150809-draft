# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmfcr2/libmfcr2-0.0.6_pre1.ebuild,v 1.1 2008/12/15 11:30:44 pva Exp $

inherit eutils

DESCRIPTION="A library for MFC/R2 signaling on E1 lines"
HOMEPAGE="http://www.soft-switch.org/"
SRC_URI="http://www.soft-switch.org/downloads/unicall/${PN}-${PV/_}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.26
	>=media-libs/libsupertone-0.0.2
	>=media-libs/spandsp-0.0.2_pre26
	>=media-libs/tiff-3.8.2-r2
	net-misc/zaptel
	>=net-libs/libunicall-0.0.3"

S=${WORKDIR}/${PN}-${PV/_pre*}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-expose-private.patch"
}

src_install () {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc ChangeLog AUTHORS NEWS README || die
}
