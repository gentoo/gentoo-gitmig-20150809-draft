# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmwifi/wmwifi-0.3.ebuild,v 1.2 2004/03/26 23:10:16 aliz Exp $

IUSE=""
HOMEPAGE="http://wmwifi.digitalssg.net"
DESCRIPTION="wireless network interface monitor dockapp"
SRC_URI="http://digitalssg.net/debian/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	myconf=""
	# make sure it uses current kernel headers to insure 
	# its using current kernels wireless ext.
	export CPPFLAGS="-I/usr/src/linux/include"

	econf  || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
}
