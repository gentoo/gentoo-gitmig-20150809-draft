# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.0.ebuild,v 1.1 2004/09/16 20:32:08 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/mp3check.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""

src_unpack() {
	unpack ${P}.tar.gz || die
	cd ${S} || die
	epatch "${FILESDIR}/mp3check-0.8.0-gcc34.diff" || die
}

src_install() {
	einstall || die
	dodoc ChangeLog FAQ HISTORY THANKS TODO
}
