# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-postgresql/jdbc2-postgresql-7.3.ebuild,v 1.12 2006/10/05 17:27:54 gustavoz Exp $

inherit java-pkg

At="pg73jdbc2.jar"
S=${WORKDIR}
DESCRIPTION="JDBC Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${At}"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="amd64 ppc x86"
IUSE=""
LICENSE="POSTGRESQL"
SLOT="5"
DEPEND=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.2"

src_install() {
	java-pkg_dojar ${DISTDIR}/${At}
}
