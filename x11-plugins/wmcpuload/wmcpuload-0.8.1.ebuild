# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpuload/wmcpuload-0.8.1.ebuild,v 1.1 2002/08/30 07:51:31 seemant Exp $

MY_P=${P/wmcpul/WMCPUL}
S=${WORKDIR}/${MY_P}
DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${MY_P}.tar.bz2"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/wmcpuload-e.html"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
