# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkinput/skkinput-2.05.ebuild,v 1.8 2004/03/14 19:47:42 usata Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha"

DESCRIPTION="A SKK-like Japanese input method for X11"
SRC_URI="http://downloads.sourceforge.jp/skkinput2/864/${P}.tar.gz"
HOMEPAGE="http://sourceforge.jp/projects/skkinput2"

IUSE=""
DEPEND="virtual/glibc
	virtual/x11
	app-i18n/skkserv"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/skkinput-ignore-numlock.patch
}

src_compile() {
	xmkmf -a || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} MANPATH=/usr/share/man install.man || die
	dodoc ChangeLog GPL skkinput.doc *.jis
	insinto /etc/skel
	newins dot.skkinput .skkinput
}
