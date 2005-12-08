# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jldap/jldap-20051000.ebuild,v 1.1 2005/12/08 13:07:53 betelgeuse Exp $

inherit base java-pkg

DESCRIPTION="The LDAP Class Libraries for Java (JLDAP) enable you to write applications to access, manage, update, and search for information stored in directories accessible using LDAPv3."
HOMEPAGE="http://www.openldap.org/jldap/"
SRC_URI="mirror://gentoo/jldap-Oct_ndk_2005-gentoo.tar.bz2"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug doc dsml jikes"

RDEPEND=">=virtual/jre-1.4
		dsml? ( =dev-java/commons-httpclient-2.0* )"
DEPEND=">=virtual/jdk-1.4
	${REDEND}
	>=dev-java/ant-core-1.5.1
	jikes? ( dev-java/jikes )"

S=${WORKDIR}/${PN}

PATCHES="${FILESDIR}/200510-javac.xml.patch"

src_compile() {
	# TODO
	# sgml support needs opensgml which is not packaged yet.
	if use debug; then
		local antflags="debug"
	else
		local antflags="release"
	fi

	use dsml && antflags="${antflags} -lib $(java-pkg_getjars commons-httpclient)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags} || die "Failed to run ant."
}

src_install() {
	dodoc README
	use dsml && dodoc README.dsml

	if use debug; then
		java-pkg_dojar lib_debug/*.jar
	else
		java-pkg_dojar lib/*.jar
	fi

	if use doc; then
		dohtml *.html
		dodoc design/*
		java-pkg_dohtml -r doc/*
	fi
}
