# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/tomcat/tomcat-4.0.1.ebuild,v 1.1 2001/11/04 23:58:41 hallski Exp $

S=${WORKDIR}/jakarta-${P}
DESCRIPTION="Apache Servlet Engine"
SRC_URI="http://jakarta.apache.org/builds/jakarta-tomcat-4.0/release/v${PV}/bin/jakarta-tomcat-4.0.1.tar.gz"
HOMEPAGE="http://jakarta.apache.org/tomcat"

RDEPEND=">=dev-lang/jdk-1.2"

src_install() {
	dodir /opt/jakarta/tomcat
	dodoc RELEASE-NOTES-* README.txt RUNNING.txt LICENSE
	rm *
	cp -Rdp * ${D}/opt/jakarta/tomcat
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21tomcat
	dodir /opt/jakarta/tomcat/log
}








