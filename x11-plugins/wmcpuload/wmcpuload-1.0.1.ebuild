# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpuload/wmcpuload-1.0.1.ebuild,v 1.1 2003/05/19 21:18:56 mholzer Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml"
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"

DEPEND="virtual/x11
	media-libs/xpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

src_install () {
	einstall || die "make install failed"
}
