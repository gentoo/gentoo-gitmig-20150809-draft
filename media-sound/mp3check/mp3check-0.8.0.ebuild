# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.0.ebuild,v 1.8 2009/05/24 19:44:46 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings."
HOMEPAGE="http://jo.ath.cx/soft/mp3check/mp3check.html"
SRC_URI="http://jo.ath.cx/soft/mp3check/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc34.diff
}

src_install() {
	einstall || die "einstall failed"
	dodoc ChangeLog FAQ HISTORY THANKS TODO
}
