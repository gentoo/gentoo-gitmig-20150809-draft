# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-1.8.2.ebuild,v 1.2 2001/12/30 04:06:13 karltk Exp $

A=Cocoon-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Web Publishing Framework for Apache"
SRC_URI="http://xml.apache.org/cocoon/dist/"${A}
HOMEPAGE="http://xml.apache.org/cocoon/"

DEPEND=">=virtual/jdk-1.2.2
	>=dev-java/fesi-1
	>=dev-java/xt-1
	>=dev-java/jndi-1.2.1"

src_unpack() {
	unpack ${A}
}

src_compile() {
	CLASSPATH=${CLASSPATH}:\
		`cat /usr/share/jndi/classpath.env`: 
		`cat /usr/share/xt/classpath.env`:
		`cat /usr/share/fesi/classpath.env`
	export CLASSPATH
	sh build.sh || die
}

src_install() {                               
	insinto /usr/share/cocoon
	for i in xerces_1_2 xalan_1_2_D02 fop_0_15_0 servlet_2_2 turbine-pool ; do
		doins  lib/$i.jar
		echo /usr/share/cocoon/$i.jar \
			>> /usr/share/cocoon/classpath.env
	done
	
	doins build/cocoon.jar
	echo /usr/share/cocoon/$i.jar >> /usr/share/cocoon/classpath.env

	mv /usr/share/cocoon/classpath.env /usr/share/cocoon/classpath.env.orig
	tr '\n' ':' < /usr/share/cocoon/classpath.env.orig \
		> /usr/share/cocoon/classpath.env
	rm /usr/share/cocoon/classpath.env.orig
	
	dodir /usr/share/jakarta/tomcat/webapps/cocoon/repository
	insinto /usr/share/jakarta/tomcat/webapps/cocoon/WEB-INF
	cp -a samples ${D}/usr/share/jakarta/tomcat/webapps/cocoon
	doins ${FILESDIR}/cocoon.properties
	doins ${FILESDIR}/web.xml
	dodoc README LICENSE
	dodir /usr/doc/${PF}/html
	dohtml -r docs/*
}


