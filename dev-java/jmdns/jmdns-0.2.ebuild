# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmdns/jmdns-0.2.ebuild,v 1.5 2004/10/22 09:11:29 absinthe Exp $

inherit java-pkg

DESCRIPTION="JmDNS is an implementation of multi-cast DNS in Java. It supports service discovery and service registration. It is fully interoperable with Apple's Rendezvous"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://jmdns.sourceforge.net"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3.1"
RDEPEND=">=virtual/jdk-1.3.1"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64"

src_compile() {
	einfo "Compiling JmDNS..."
	javac ${S}/src/javax/jmdns/*
	einfo "Compiling tools..."
	javac -classpath ${S}/src ${S}/src/com/strangeberry/jmdns/tools/*
	einfo "Making jars..."
	jar cf jmdns.jar -C ${S}/src javax
	echo "Main-class: com.strangeberry.jmdns.tools.Main" > jmdns-tools-manifest
	jar cmf jmdns-tools-manifest jmdns-tools.jar -C ${S}/src com -C ${S}/src javax
}

src_install() {
	java-pkg_dojar jmdns*.jar
	dodoc README.txt LICENSE.txt
	use doc && java-pkg_dohtml -r docs/*
}
