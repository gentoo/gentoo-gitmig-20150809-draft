# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tlf/tlf-0.9.23.ebuild,v 1.5 2006/10/30 10:31:36 flameeyes Exp $

inherit flag-o-matic

DESCRIPTION="Console-mode amateur radio contest logger"
HOMEPAGE="http://home.iae.nl/users/reinc/TLF-0.2.html"
SRC_URI="http://sharon.esrac.ele.tue.nl/pub/linux/ham/tlf/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/ncurses
	media-libs/hamlib"

DEPEND="${RDEPEND}
	sys-apps/gawk"

src_compile() {
	append-flags -L/usr/lib/hamlib
	econf --enable-hamlib \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"
}
