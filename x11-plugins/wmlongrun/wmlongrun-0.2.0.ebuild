# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlongrun/wmlongrun-0.2.0.ebuild,v 1.1 2004/07/17 14:24:57 s4t4n Exp $

DESCRIPTION="A dockapp to monitor LongRun on a Transmeta Crusoe processor"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml"
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/x11"
IUSE=""

# Since this will only work with a Crusoe processor, it's safe to assume that
# the functionality is only available on x86.
KEYWORDS="~x86 -*"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc README AUTHORS TODO COPYING MAKEDEV-cpuid-msr
}
