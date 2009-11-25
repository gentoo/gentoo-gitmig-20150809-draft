# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libptp2/libptp2-1.1.10.ebuild,v 1.5 2009/11/25 09:53:23 maekke Exp $

inherit eutils autotools

DESCRIPTION="Library and client for communicating with PTP enabled devices (e.g. digital photo cameras)."
HOMEPAGE="http://sourceforge.net/projects/libptp/"
SRC_URI="mirror://sourceforge/libptp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RDEPEND=">=dev-libs/libusb-0.1.10"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	cd "${S}"
	AT_M4DIR="m4" eautoreconf
}

src_test() {
	env LD_LIBRARY_PATH=./src/.libs/ ./src/ptpcam -l || die "failed test"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
