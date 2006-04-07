# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.0.ebuild,v 1.6 2006/04/07 01:13:24 tcort Exp $

IUSE=""

inherit eutils

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/mp3check.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc sparc x86"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/mp3check-0.8.0-gcc34.diff"
}

src_install() {
	einstall || die
	dodoc ChangeLog FAQ HISTORY THANKS TODO
}
