# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkinput/skkinput-2.06.4.ebuild,v 1.5 2004/06/28 02:04:39 vapier Exp $

DESCRIPTION="A SKK-like Japanese input method for X11"
HOMEPAGE="http://skkinput2.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/skkinput2/6273/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND="virtual/x11"
RDEPEND="${DEPEND}
	virtual/skkserv"

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
