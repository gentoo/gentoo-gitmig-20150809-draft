# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-1.8.2.ebuild,v 1.5 2002/07/14 20:25:23 aliz Exp $

A=Cocoon-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Web Publishing Framework for Apache"
SRC_URI="http://xml.apache.org/cocoon/dist/"${A}
HOMEPAGE="http://xml.apache.org/cocoon/"
KEYWORDS="x86"
SLOT="0"
LICENSE="Apache-1.1"

DEPEND=">=virtual/jdk-1.2.2
	>=dev-java/fesi-1
	>=dev-java/xt-1
	>=dev-java/jndi-1.2.1"

src_unpack() {
	unpack ${A}
}

src_compile() {
	export CLASSPATH=`java-config --full-classpath=jndi,xt,fesi`
	sh build.sh || die
}

src_install() {                  
	dojar lib/*.jar             

	dojar build/cocoon.jar

	dodir /usr/share/jakarta/tomcat/webapps/cocoon/repository
	insinto /usr/share/jakarta/tomcat/webapps/cocoon/WEB-INF
	cp -a samples ${D}/usr/share/jakarta/tomcat/webapps/cocoon
	doins ${FILESDIR}/cocoon.properties
	doins ${FILESDIR}/web.xml
	dodoc README LICENSE
	dohtml -r docs/*
}


