# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rxtx/rxtx-2.1.7_pre17.ebuild,v 1.2 2005/05/17 18:15:44 luckyduck Exp $

inherit java-pkg

NP=rxtx-2.1-7pre17

DESCRIPTION="Native lib providing serial and parallel communication for Java"
HOMEPAGE="http://rxtx.org/"
SRC_URI="ftp://jarvi.dsl.frii.com/pub/rxtx/${NP}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${NP}"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Make failed"
}

src_install() {
	java-pkg_dojar RXTXcomm.jar
	java-pkg_doso $CHOST/.libs/*.so
	dodoc AUTHORS ChangeLog PORTING TODO SerialPortInstructions.txt
	java-pkg_dohtml RMISecurityManager.html
}
