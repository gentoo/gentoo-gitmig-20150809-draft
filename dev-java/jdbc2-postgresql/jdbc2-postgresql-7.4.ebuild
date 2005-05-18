# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-postgresql/jdbc2-postgresql-7.4.ebuild,v 1.3 2005/05/18 11:20:54 corsair Exp $

inherit java-pkg

At="pg74.215.jdbc2.jar"
S=${WORKDIR}
DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${At}"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ppc64"
IUSE=""
LICENSE="POSTGRESQL"
SLOT="6"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"

src_compile() {
	einfo "This is a binary-only ebuild (for now)."
}

src_install() {
	java-pkg_dojar ${DISTDIR}/${At}
}
