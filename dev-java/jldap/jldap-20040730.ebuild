# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jldap/jldap-20040730.ebuild,v 1.2 2004/07/30 03:03:51 axxo Exp $

inherit java-pkg

DESCRIPTION="The LDAP Class Libraries for Java (JLDAP) enable you to write applications to access, manage, update, and search for information stored in directories accessible using LDAPv3. JLDAP was developed by Novell."

HOMEPAGE="http://www.openldap.org/jldap/"
SRC_URI="mirror://gentoo/jldap-Sep_ndk_2003-gentoo.tar.bz2"
IUSE="doc jikes"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5.1
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.2"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags} || die "Blast it all!!"
}

src_install() {
	dodoc COPYRIGHT LICENSE README
	java-pkg_dojar lib/*
	use doc && dohtml -r doc/*
}
