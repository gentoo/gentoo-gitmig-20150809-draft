# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/axis/axis-1.2_rc2.ebuild,v 1.10 2007/05/08 20:58:39 caster Exp $

inherit eutils java-pkg

MY_PV="${PV//./_}"
MY_PV="${MY_PV/_rc2/RC2}"
MY_P="${PN}-${MY_PV}"
SRCFILE="${MY_P}-src.tar.gz"
DESCRIPTION="Apache Axis SOAP implementation"
HOMEPAGE="http://ws.apache.org/axis/"
SRC_URI="mirror://apache/ws/${PN}/${MY_PV}/${SRCFILE}"

LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="x86 amd64"
IUSE="debug doc"

RDEPEND=">=virtual/jre-1.4
		=dev-java/servletapi-2.4*
		dev-java/commons-logging
		dev-java/commons-discovery
		dev-java/log4j
		dev-java/wsdl4j
		>=dev-java/xerces-2.7
		=dev-java/rhino-1.5*
		=dev-java/castor-0.9*
		>=dev-java/sun-jimi-1.0
		=dev-java/commons-httpclient-2*
		>=dev-java/bsf-2.3
		dev-java/sun-jaf-bin
		dev-java/sun-javamail-bin"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		>=dev-java/ant-1.6"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/axis-1.2-gentoo.patch

	find . -name "*.jar" -exec rm {} \;

	cd ${S}/lib
	java-pkg_jar-from commons-discovery
	java-pkg_jar-from commons-logging
	java-pkg_jar-from log4j
	java-pkg_jar-from wsdl4j
	java-pkg_jar-from sun-jaf-bin
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from sun-javamail-bin
	java-pkg_jar-from xerces-2
	java-pkg_jar-from sun-jimi
	java-pkg_jar-from castor-0.9
	java-pkg_jar-from commons-httpclient
	java-pkg_jar-from bsf-2.3
}

src_compile() {
	local antflags="compile -Ddeprecation=false -Dbase.path=/opt"
	use doc && antflags="${antflags} javadocs"
	use debug && antflags="${antflags} -Ddebug=on"
	use !debug && antflags="${antflags} -Ddebug=off"
	ant ${antflags} || die "compilation problem"
}

src_install() {
	java-pkg_dojar build/lib/axis*.jar
	java-pkg_dojar build/lib/jaxrpc.jar
	java-pkg_dojar build/lib/saaj.jar

	if use doc; then
		dodoc ${S}/release-notes.html ${S}/release-notes.html ${S}/doc/*
		java-pkg_dohtml ${S}/build/javadocs/
	fi
}
