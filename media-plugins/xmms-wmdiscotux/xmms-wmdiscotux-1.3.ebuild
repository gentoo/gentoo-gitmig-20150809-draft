# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-wmdiscotux/xmms-wmdiscotux-1.3.ebuild,v 1.4 2004/03/26 21:21:12 eradicator Exp $

inherit eutils

IUSE=""

MY_P=${P/xmms-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="XMMS visualization plugin of a dockable, headbanging Tux."
HOMEPAGE="http://fragment.stc.cx/?page=wmdiscotux"
SRC_URI="http://fragment.stc.cx/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	# patch fixes the Makefile for portage
	epatch ${FILESDIR}/${P}-makefile.patch
	# patch fixes strange escaping in wmdiscotux.c
	epatch ${FILESDIR}/${P}-gcc-3.3.patch
}

src_compile() {
	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING
}
