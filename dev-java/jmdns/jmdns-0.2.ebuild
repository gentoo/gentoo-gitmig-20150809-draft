# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmdns/jmdns-0.2.ebuild,v 1.7 2005/07/16 09:24:00 axxo Exp $

inherit java-pkg

DESCRIPTION="JmDNS is an implementation of multi-cast DNS in Java. It supports service discovery and service registration. It is fully interoperable with Apple's Rendezvous"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://jmdns.sourceforge.net"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3.1"
RDEPEND=">=virtual/jre-1.3.1"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64"

src_compile() {
	echo "Compiling JmDNS..."
	javac ${S}/src/javax/jmdns/* || die
	echo "Compiling tools..."
	javac -classpath ${S}/src ${S}/src/com/strangeberry/jmdns/tools/* || die
	echo "Making jars..."
	jar cf jmdns.jar -C ${S}/src javax || die
	echo "Main-class: com.strangeberry.jmdns.tools.Main" > jmdns-tools-manifest
	jar cmf jmdns-tools-manifest jmdns-tools.jar -C ${S}/src com -C ${S}/src javax || die
}

src_install() {
	java-pkg_dojar jmdns*.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r docs/*
}
