# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.14.ebuild,v 1.4 2002/10/04 04:54:48 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A nice command line todo list for developers"
SRC_URI="http://devtodo.sourceforge.net/${PV}/${P}.tar.gz"
HOMEPAGE="http://devtodo.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"


src_compile() {

	econf --sysconfdir=/etc/devtodo || die
	make || die
}

src_install () {
    make DESTDIR=${D} install || die

    dodoc AUTHORS COPYING ChangeLog QuickStart README TODO 
	dodoc doc/scripts.sh doc/scripts.tcsh doc/todorc.example contrib/tdrec
}
