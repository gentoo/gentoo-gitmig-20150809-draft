# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xstow/xstow-0.4.6.ebuild,v 1.1 2003/04/02 23:53:58 liquidx Exp $

IUSE="ncurses"

inherit eutils

DESCRIPTION="XStow is a replacement for GNU stow with extensions"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://xstow.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	ncurses? ( sys-libs/ncurses )"

src_unpack() {
	unpack ${A}
    epatch ${FILESDIR}/${P}-configure-ncurses.diff
}

src_compile() {
	local myconf
	use ncurses || myconf="--without-ncurses"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		${myconf} || die
	emake || die
}

src_install() {
	dodoc README AUTHORS COPYING NEWS README TODO ChangeLog
	make DESTDIR=${D} PACKAGE=${P} install || die
}
