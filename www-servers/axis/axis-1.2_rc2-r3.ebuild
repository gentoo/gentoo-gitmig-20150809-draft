# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/axis/axis-1.2_rc2-r3.ebuild,v 1.2 2007/11/18 10:28:31 opfer Exp $

WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV//./_}"
MY_PV="${MY_PV/_rc2/RC2}"
MY_P="${PN}-${MY_PV}"
SRCFILE="${MY_P}-src.tar.gz"
DESCRIPTION="Apache Axis SOAP implementation"
HOMEPAGE="http://ws.apache.org/axis/"
SRC_URI="mirror://apache/ws/${PN}/${MY_PV}/${SRCFILE}"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 x86"
IUSE="debug doc"

COMMON_DEPEND="
		=dev-java/servletapi-2.4*
		dev-java/commons-logging
		dev-java/commons-discovery
		dev-java/log4j
		dev-java/wsdl4j
		>=dev-java/xerces-2.7
		=dev-java/rhino-1.5*
		>=dev-java/castor-1.0
		>=dev-java/sun-jimi-1.0
		=dev-java/commons-httpclient-3*
		>=dev-java/bsf-2.3
		dev-java/sun-jaf
		dev-java/sun-javamail"
RDEPEND="
		>=virtual/jre-1.4
		${COMMON_DEPEND}"
DEPEND="=virtual/jdk-1.4*
		${COMMON_DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/axis-1.2-gentoo.patch"

	find . -name "*.jar" -exec rm -v {} \;

	cd "${S}/lib"
	java-pkg_jar-from commons-discovery
	java-pkg_jar-from commons-logging
	java-pkg_jar-from log4j
	java-pkg_jar-from wsdl4j
	java-pkg_jar-from sun-jaf
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from sun-javamail
	java-pkg_jar-from xerces-2
	java-pkg_jar-from sun-jimi
	java-pkg_jar-from castor-1.0
	java-pkg_jar-from commons-httpclient-3
	java-pkg_jar-from bsf-2.3
}

src_compile() {
	local antflags="compile -Ddeprecation=false -Dbase.path=/opt"
	use debug && antflags="${antflags} -Ddebug=on"
	use !debug && antflags="${antflags} -Ddebug=off"
	# has prebuild javadocs
	eant ${antflags}
}

src_install() {
	java-pkg_dojar build/lib/axis*.jar
	java-pkg_dojar build/lib/jaxrpc.jar
	java-pkg_dojar build/lib/saaj.jar

	dohtml release-notes.html changelog.html || die
	if use doc; then
		java-pkg_dohtml -r docs/*
		dosym /usr/share/doc/${PF}/html/{apiDocs,api} || die
	fi
}
