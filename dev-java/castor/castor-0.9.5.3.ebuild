# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/castor/castor-0.9.5.3.ebuild,v 1.4 2005/03/23 14:42:51 gustavoz Exp $

inherit eutils java-pkg

DESCRIPTION="Data binding framework for Java"
SRC_URI="ftp://ftp.exolab.org/pub/castor/castor_${PV}/castor-${PV}-src.tgz"
HOMEPAGE="http://castor.exolab.org/"
LICENSE="Exolab"
KEYWORDS="~x86 ~amd64 ~sparc"
SLOT="0.9"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

RDEPEND=">=virtual/jre-1.4
	>=dev-java/ant-core-1.5
	>=dev-java/adaptx-0.9.5.3
	>=dev-java/commons-logging-1.0.4
	>=dev-java/oro-2.0.5
	>=dev-java/regexp-1.3
	>=dev-java/jta-1.0.1
	>=dev-java/ldapsdk-4.1.7
	>=dev-java/junit-3.8
	>=dev-java/log4j-1.2.8
	>=dev-java/jdbc2-postgresql-7.3
	=dev-java/servletapi-2.3*
	=dev-java/xerces-1.3*"

src_unpack() {
	unpack ${A}

	cd ${S}/src
	epatch ${FILESDIR}/build-xml.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from adaptx-0.9
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from commons-logging
	java-pkg_jar-from oro
	java-pkg_jar-from regexp
	java-pkg_jar-from jta
	java-pkg_jar-from junit
	java-pkg_jar-from log4j
	java-pkg_jar-from jdbc2-postgresql-6
	java-pkg_jar-from servletapi-2.3
	java-pkg_jar-from xerces-1.3
	java-pkg_jar-from ldapsdk-4.1 ldapjdk.jar
}


src_compile() {
	cd ${S}/src

	local antflags="jar"
	if use doc; then
		antflags="${antflags} javadoc"
	fi
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	if use doc; then
		java-pkg_dohtml -r build/doc/javadoc/*
	fi
}
