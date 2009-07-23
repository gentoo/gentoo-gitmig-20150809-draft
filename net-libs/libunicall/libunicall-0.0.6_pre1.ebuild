# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libunicall/libunicall-0.0.6_pre1.ebuild,v 1.5 2009/07/23 19:43:36 volkmar Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="An abstration layer for telephony signalling"
HOMEPAGE="http://www.soft-switch.org/"
SRC_URI="http://www.soft-switch.org/downloads/unicall/${PN}-${PV/_}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/audiofile-0.2.6-r1
	>=media-libs/spandsp-0.0.6_pre3
	>=media-libs/tiff-3.8.2-r2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${PV/_pre*}

src_prepare() {
	# do not compile test program
	sed -i -e "/testcall/d" Makefile.am || die "sed failed"

	epatch "${FILESDIR}/${P}--as-needed.2.patch"
	eautoreconf
}

src_compile() {
	# bug #277783
	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README || die "dodoc failed"
}
