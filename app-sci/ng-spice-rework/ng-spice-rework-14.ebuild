# Copyright 1999-2003 Gentoo Technologies, Inc. and Tim Yamin <plasmaroo@gentoo.org> <plasmaroo@squirrelsoft.org.uk>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ng-spice-rework/ng-spice-rework-14.ebuild,v 1.1 2003/11/28 21:26:50 plasmaroo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="NGSpice - The Next Generation Spice (Circuit Emulator)"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://ngspice.sourceforge.net"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README

}
