# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ng-spice-rework/ng-spice-rework-15.ebuild,v 1.1 2004/02/01 17:48:17 plasmaroo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="NGSpice - The Next Generation Spice (Circuit Emulator)"
SRC_URI="http://www.geda.seul.org/dist/ngspice-rework${PV}.tgz"
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
