# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/larswm/larswm-7.5.1.ebuild,v 1.1 2004/06/22 16:03:03 usata Exp $

DESCRIPTION="Tiling window manager for X11, based on 9wm by David Hogan."
HOMEPAGE="http://larswm.fnurt.net/"
SRC_URI="http://larswm.fnurt.net/${P}.tar.gz"
LICENSE="9wm"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11"

src_compile() {
	xmkmf -a || die
	emake || die

	cp sample.xsession larswm-session
}

src_install() {
	dobin larsclock larsmenu larsremote larswm larswm-session
	for x in *.man ; do
		newman $x ${x/man/1}
	done
	dodoc ChangeLog README* sample.*

	insinto /etc/X11
	newins sample.larswmrc larswmrc || die
	insinto /usr/share/xsessions
	doins ${FILESDIR}/larswm.desktop || die
}
