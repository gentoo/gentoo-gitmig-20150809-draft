# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jldap/jldap-20060300.ebuild,v 1.2 2007/04/28 20:19:05 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="The LDAP Class Libraries for Java (JLDAP) enable you to write applications to access, manage, update, and search for information stored in directories accessible using LDAPv3."
HOMEPAGE="http://www.openldap.org/jldap/"
SRC_URI="mirror://gentoo/jldap-Mar_ndk_2006-gentoo.tar.bz2"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
		=dev-java/commons-httpclient-2.0*
		dev-java/openspml
		dev-java/openspml2"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S="${WORKDIR}/openldap-${PN}"

src_unpack() {

	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/200603-javac.xml.patch"

}

src_compile() {

	java-ant_bsfix_one "${S}/javac.xml"

	mkdir "${S}/ext"
	cd "${S}/ext"
	java-pkg_jar-from commons-httpclient
	java-pkg_jar-from openspml
	java-pkg_jar-from openspml2

	cd "${S}"
	local antflags="release"
	use doc && antflags="${antflags} doc"

	eant ${antflags}

}

src_install() {

	dodoc README
	dodoc README.dsml

	java-pkg_dojar lib/ldap.jar

	if use doc; then
		dohtml *.html
		dodoc design/*
		java-pkg_dohtml -r doc/*
	fi

	use source && java-pkg_dosrc org com

}
