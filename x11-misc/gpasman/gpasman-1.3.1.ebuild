# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gpasman/gpasman-1.3.1.ebuild,v 1.1 2003/10/18 06:31:18 raker Exp $

DESCRIPTION="Gpasman: GTK Password manager"
SRC_URI="http://gpasman.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://gpasman.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="=x11-libs/gtk+-1.2*"

src_install() {
	dodir /usr/bin
	emake prefix=${D}/usr install

	dodoc ChangeLog AUTHORS README BUGS NEWS
}
