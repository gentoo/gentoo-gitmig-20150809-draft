# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/w_scan/w_scan-20090502.ebuild,v 1.1 2009/05/02 18:28:38 hd_brummy Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Scan for DVB-C/DVB-T/DVB-C channels without prior knowledge of frequencies and modulations"
HOMEPAGE="http://wirbel.htpc-forum.de/w_scan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/w_scan/dev/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-tv/linuxtv-dvb-headers"
RDEPEND="${DEPEND}
		>=sys-kernel/linux-headers-2.6.29"

src_prepare() {
	epatch "${FILESDIR}/${P}-build-and-path-fixes.patch"
	emake clean || die "emake clean failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README
}

pkg_postinst() {
	echo
	elog "This is a new developer branch an need some tests"
	elog "with different DVB-S Cards, LNB's, diseqc switches ..."
	echo
	elog "https://bugs.gentoo.org/show_bug.cgi?id=268320"
}
