# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3ed/id3ed-1.10.4.ebuild,v 1.17 2007/08/19 16:06:32 drac Exp $

inherit toolchain-funcs

DESCRIPTION="ID3 tag editor for mp3 files"
HOMEPAGE="http://www.dakotacom.net/~donut/programs/id3ed.html"
SRC_URI="http://www.dakotacom.net/~donut/programs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-s::" Makefile.in
}

src_compile() {
	econf
	emake CXX="$(tc-getCXX)" CFLAGS="${CFLAGS} -I./" || die "emake failed."
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README ChangeLog
}
