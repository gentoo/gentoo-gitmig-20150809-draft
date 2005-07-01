# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/jwm/jwm-0.21.ebuild,v 1.4 2005/07/01 21:57:27 josejx Exp $

IUSE=""

DESCRIPTION="Joe's window manager"
SRC_URI="http://joewing.net/programs/jwm/${P}.tar.bz2"
HOMEPAGE="http://joewing.net/programs/jwm/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

DEPEND="virtual/x11"

src_install() {
	dodir /usr/bin
	dodir /etc
	dodir /usr/share/man
	make BINDIR=${D}/usr/bin SYSCONF=${D}/etc MANDIR=${D}/usr/share/man install || die

	echo "#!/bin/sh" > jwm
	echo "exec /usr/bin/jwm" >> jwm
	exeinto /etc/X11/Sessions
	doexe jwm
}
