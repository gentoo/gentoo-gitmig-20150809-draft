# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbconf/bbconf-1.2.ebuild,v 1.11 2003/02/13 17:07:20 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="All-in-one blackbox configuration tool."
SRC_URI="http://${PN}.sourceforge.net/code/${P}.tar.gz"
HOMEPAGE="http://bbconf.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11
	=x11-libs/qt-2*"

#RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
}
