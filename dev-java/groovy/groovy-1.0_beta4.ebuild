# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/groovy/groovy-1.0_beta4.ebuild,v 1.5 2005/01/05 22:16:31 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Groovy is a high-level dynamic language for the JVM"
HOMEPAGE="http://groovy.codehaus.org/"
SRC_URI="http://dist.codehaus.org/groovy/distributions/${PN}-1.0-beta-4-src.tar.gz"
LICENSE="codehaus-groovy"
SLOT="1"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="=dev-java/xerces-2.6*
	=dev-java/commons-cli-1.0*
	=dev-java/ant-1.5*
	=dev-java/junit-3.8*
	=dev-java/asm-1.4*
	=dev-java/classworlds-1.0*
	=dev-java/mockobjects-0.0*
	=dev-java/bsf-2.3*
	=www-servers/tomcat-5*
	=dev-java/xmojo-bin-5.0*"
# karltk:
# xmojo-bin is a JMX provider, we should add a list of alternatives


S=${WORKDIR}/${PN}-1.0-beta-4

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml || die
	mkdir -p ${S}/target/lib
	(
		cd ${S}/target/lib
		java-pkg_jar-from xerces || die
		java-pkg_jar-from asm-1.4 || die
		java-pkg_jar-from commons-cli || die
		java-pkg_jar-from junit || die
		java-pkg_jar-from classworlds || die
		java-pkg_jar-from bsf-2.3 || die
		java-pkg_jar-from mockobjects || die
		java-pkg_jar-from xmojo-bin-5.0 || die
		ln -s /opt/tomcat/common/lib/servlet-api.jar .
	)

	# The original build.xml will only build on a MacOSX machine when you're
	# logged in as jstrachan. I don't reckon many Gentoo users are...
	cp ${FILESDIR}/build.xml-${PV} ${S}/build.xml || die "Failed to update build.xml"

	# This won't compile without an incestuous relationship with radeox.
	rm -rf ${S}/src/main/org/codehaus/groovy/wiki
}

src_compile() {
	ant jar || die
	if use doc ; then
		ant javadoc || die
	fi
}

src_install() {
	dodoc LICENSE.txt
	java-pkg_dojar target/groovy-1.0-beta-2.jar
	if use doc ; then
		java-pkg_dohtml -r dist/docs/api
	fi
}
