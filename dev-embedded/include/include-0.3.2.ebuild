# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/include/include-0.3.2.ebuild,v 1.2 2004/02/24 16:10:33 bazik Exp $

DESCRIPTION="This is a collection of the useful independent include files for C/Assembler developers."
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"
HOMEPAGE="http://openwince.sourceforge.net/include/"
KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="BSD"

src_compile(){
	./configure
}

src_install(){
	make DESTDIR=${D} install
}




