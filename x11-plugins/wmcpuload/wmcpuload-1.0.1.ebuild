# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpuload/wmcpuload-1.0.1.ebuild,v 1.11 2004/09/03 02:51:34 tgall Exp $

IUSE=""
DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml"
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc ~mips ppc64"

src_install () {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
}
