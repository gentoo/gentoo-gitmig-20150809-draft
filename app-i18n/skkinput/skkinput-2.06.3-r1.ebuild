# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkinput/skkinput-2.06.3-r1.ebuild,v 1.6 2004/04/06 04:01:44 vapier Exp $

inherit eutils

DESCRIPTION="A SKK-like Japanese input method for X11"
HOMEPAGE="http://skkinput2.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/skkinput2/1815/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}
	virtual/skkserv"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/skkinput-ignore-numlock.patch
}

src_compile() {
	xmkmf -a || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} MANPATH=/usr/share/man install.man || die
	dodoc ChangeLog GPL *.jis
	insinto /etc/skel
	newins dot.skkinput .skkinput
}
