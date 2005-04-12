# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-postgresql/jdbc3-postgresql-7.3.ebuild,v 1.11 2005/04/12 20:03:03 luckyduck Exp $

inherit java-pkg

At="pg73jdbc3.jar"
S=${WORKDIR}
DESCRIPTION="JDBC3 Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${At}"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="x86 sparc amd64 ppc"
IUSE=""
LICENSE="POSTGRESQL"
SLOT="1"
DEPEND=""
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	einfo "This is a binary-only ebuild (for now)."
}

src_install() {
	java-pkg_dojar ${DISTDIR}/${At}
}
