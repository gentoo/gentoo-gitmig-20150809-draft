# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hibernate/hibernate-2.1.2.ebuild,v 1.2 2004/03/21 19:41:11 dholm Exp $

inherit java-pkg

DESCRIPTION="Hibernate is a powerful, ultra-high performance object / relational persistence and query service for Java."
SRC_URI="mirror://sourceforge/hibernate/${PN}-${PV}.tar.gz"
HOMEPAGE="http://hibernate.bluemars.net"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.5
		>=dev-java/log4j-1.2.7
		dev-java/dom4j
		dev-java/commons-dbcp
		dev-java/commons-pool
		dev-java/commons-logging"
IUSE="doc"

S=${WORKDIR}/${PN}-${PV/.2}

src_compile() { :; }

src_install() {
	java-pkg_dojar hibernate2.jar lib/cglib*.jar lib/jcs*.jar lib/odmg*.jar lib/c3p0*.jar
	dodoc *.txt lib/c3p0*.txt
	use doc && dohtml -r doc/*
}
