# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkinput/skkinput-2.05.ebuild,v 1.12 2004/06/28 02:04:39 vapier Exp $

inherit eutils

DESCRIPTION="A SKK-like Japanese input method for X11"
HOMEPAGE="http://sourceforge.jp/projects/skkinput2"
SRC_URI="http://downloads.sourceforge.jp/skkinput2/864/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND="virtual/libc
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

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} MANPATH=/usr/share/man install.man || die
	dodoc ChangeLog GPL skkinput.doc *.jis
	insinto /etc/skel
	newins dot.skkinput .skkinput
}
