# Copyright 1999-2003 Gentoo Technologies, Inc. and Luke-Jr
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/azureus-bin/azureus-bin-2.0.3.2.ebuild,v 1.1 2003/11/26 05:34:17 luke-jr Exp $

inherit java-pkg

IUSE="gtk motif"

DESCRIPTION="Bittorrent client in Java"
SRC_URI="gtk? ( http://devurandom.net/azureus/files/files/${P/-bin/}-gtk.tar.bz2 )
		!gtk? ( http://devurandom.net/azureus/files/files/${P/-bin/}-motif.tar.bz2 )"
HOMEPAGE="http://http://azureus.sourceforge.net"
S=${WORKDIR}/${PN/-bin/}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=virtual/jdk-1.4.1"

src_unpack() {
	unpack ${A}
	cd ${S} || die "${S} does not exist"
	sed -i -e "s%"AZDIR\=\.*$"%"AZDIR\=/opt/azureus"%" azureus || die "sed azureus failed"
}

src_compile() {
	einfo "No compilation required"
}

src_install() {
	#install jar files
	dodir /opt/azureus
	insinto /opt/azureus
	doins *.jar

	into /usr

	#install docs
	dodoc *.txt README.linux

	#install html
	dodoc *.html

	#install libraries and binary
	newbin ${FILESDIR}/azureus.sh azureus

	into /opt/azureus
	dolib *.so
}
