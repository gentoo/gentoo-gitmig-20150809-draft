# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qhacc/qhacc-2.9.ebuild,v 1.2 2003/09/06 22:21:02 msterret Exp $

inherit kde-base
need-qt 3

DESCRIPTION="Personal Finance for QT"
HOMEPAGE="http://qhacc.sourceforge.net"
SRC_URI="mirror://sourceforge/sourceforge/qhacc/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86"

src_compile() {
	./configure --with-qhacc-includes=${S}/src || die
}

pkg_postinst() {
	mkdir /etc/qhacc
	cp -R $S/contrib/easysetup/* /etc/qhacc/
	einfo "Copy the files in /etc/qhacc to ~/.qhacc,
	You have to run this program with the command:
	qhacc -f ~/.qhacc/
	I prefer to put this in my .bashrc
	alias qhacc=\"qhacc -f ~/.qhacc\""
}
