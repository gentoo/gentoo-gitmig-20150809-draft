# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-4.1.18.ebuild,v 1.1 2003/03/17 02:56:46 absinthe Exp $

S=${WORKDIR}/jakarta-${P}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/jakarta-tomcat-4.0/release/v${PV}/bin/jakarta-tomcat-${PV}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/tomcat"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="Apache-1.1"
SLOT="0"
DEPEND=">=virtual/jdk-1.2"

src_install() {
	dodir /opt/jakarta/tomcat
	dodir /opt/jakarta/tomcat/logs
	dodir /opt/jakarta/tomcat/temp
	dodir /opt/jakarta/tomcat/work
	touch ${D}/opt/jakarta/tomcat/logs/.keep
	touch ${D}/opt/jakarta/tomcat/temp/.keep
	touch ${D}/opt/jakarta/tomcat/work/.keep

	# servlet.jar is sometimes required by other packages at build-time
	# so we will include it here.
	dojar common/lib/servlet.jar

	dodoc RELEASE-NOTES-* README.txt RUNNING.txt LICENSE RELEASE-PLAN-4.1.txt
	
	cp -Rdp bin common conf server shared webapps work ${D}/opt/jakarta/tomcat
	
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21tomcat
}

