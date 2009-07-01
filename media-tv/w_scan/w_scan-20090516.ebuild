# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/w_scan/w_scan-20090516.ebuild,v 1.2 2009/07/01 12:47:27 zzam Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Scan for DVB-C/DVB-T/DVB-C channels without prior knowledge of frequencies and modulations"
HOMEPAGE="http://wirbel.htpc-forum.de/w_scan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/w_scan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~media-tv/linuxtv-dvb-headers-5"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-build-and-path-fixes.patch"
	emake clean || die "emake clean failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README
}
