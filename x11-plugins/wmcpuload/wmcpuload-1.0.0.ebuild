# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpuload/wmcpuload-1.0.0.ebuild,v 1.3 2003/02/13 17:28:57 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/#wmcpuload"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

}
