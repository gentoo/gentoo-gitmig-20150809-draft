# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/khacc/khacc-1.7.8.ebuild,v 1.3 2004/03/19 14:20:55 weeve Exp $
inherit kde

need-kde 3

newdepend "=app-office/qhacc-2.9.8"

DESCRIPTION="KDE personal accounting system based on QHacc."
HOMEPAGE="http://qhacc.sourceforge.net"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz"
KEYWORDS="~x86 ~sparc"

src_compile() {
	myconf="$myconf --with-qhacc-includes=/usr/include --with-qhacc-libs=/usr/lib --with-qhacc-config=/usr/bin"
	kde_src_compile
}

pkg_postinst() {
	einfo "Copy the files in /etc/qhacc to ~/.qhacc,
	You have to run this program with the command:
	khacc -f ~/.qhacc/
	I prefer to put this in my .bashrc
	alias khacc=\"khacc -f ~/.qhacc\""
}
