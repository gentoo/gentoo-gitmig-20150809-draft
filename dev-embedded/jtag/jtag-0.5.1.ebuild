# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/jtag/jtag-0.5.1.ebuild,v 1.2 2004/02/24 16:11:15 bazik Exp $

DESCRIPTION="JTAG Tools is a software package which enables working with JTAG-aware (IEEE 1149.1) hardware devices (parts) and boards through JTAG adapter."
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"
HOMEPAGE="http://openwince.sourceforge.net/jtag/"
KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="dev-embedded/include"


src_compile(){
	./configure
	make
}

src_install(){
	make DESTDIR=${D} install
}




