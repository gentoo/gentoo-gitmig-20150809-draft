# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tlf/tlf-1.0.0.ebuild,v 1.4 2011/02/13 19:19:43 armin76 Exp $

inherit flag-o-matic multilib

DESCRIPTION="Console-mode amateur radio contest logger"
HOMEPAGE="http://home.iae.nl/users/reinc/TLF-0.2.html"
SRC_URI="http://www.hs-mittweida.de/tb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/hamlib"
DEPEND="${RDEPEND}
	sys-apps/gawk"

src_compile() {
	append-flags -L/usr/$(get_libdir)/hamlib
	econf --enable-hamlib
	emake || die "emake failed."
}

src_install() {
	einstall || die "einstall failed."
	rm -fR "${D}"/usr/share/${PN}/doc
	dodoc AUTHORS ChangeLog NEWS doc/README
}
