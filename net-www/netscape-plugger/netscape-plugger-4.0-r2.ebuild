# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-plugger/netscape-plugger-4.0-r2.ebuild,v 1.5 2003/09/06 01:54:09 msterret Exp $

inherit nsplugins

MYP=${P#netscape-}-linux-x86-glibc
S=${WORKDIR}/plugger-4.0
DESCRIPTION="Plugger 4.0 streaming media plugin"
SRC_URI="http://fredrik.hubbe.net/plugger/"${MYP}.tar.gz
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SLOT="0"
KEYWORDS="x86 -ppc ~sparc "
LICENSE="GPL-2"
DEPEND="virtual/glibc"
IUSE=""

src_install() {
	cd ${S}
	dodir /opt/netscape/plugins /etc
	insinto /opt/netscape/plugins
	doins plugger.so
	insinto /etc
	doins pluggerrc
	dodoc README COPYING
	doman plugger.7
	insinto /usr/bin
	dobin plugger-4.0
	dosym plugger-4.0 /usr/bin/plugger

	inst_plugin /opt/netscape/plugins/plugger.so

	dodoc README
}
