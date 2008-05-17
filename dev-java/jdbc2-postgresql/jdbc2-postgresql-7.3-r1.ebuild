# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-postgresql/jdbc2-postgresql-7.3-r1.ebuild,v 1.3 2008/05/17 10:41:11 nixnut Exp $

inherit java-pkg-2

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
