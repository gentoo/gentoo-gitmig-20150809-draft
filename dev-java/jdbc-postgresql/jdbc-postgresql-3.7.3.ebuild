# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-postgresql/jdbc-postgresql-3.7.3.ebuild,v 1.1 2003/05/14 08:11:46 absinthe Exp $

inherit java-pkg

At="pg73jdbc3.jar"
S=${WORKDIR}
DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${At}"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
LICENSE="GPL-2"
SLOT="3"
DEPEND=""
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	einfo "This is a binary-only ebuild (for now)."
} 

src_install() {
	java-pkg_dojar ${DISTDIR}/${At}
}
