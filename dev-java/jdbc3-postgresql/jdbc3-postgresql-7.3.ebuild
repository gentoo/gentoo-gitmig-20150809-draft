# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-postgresql/jdbc3-postgresql-7.3.ebuild,v 1.13 2006/10/05 17:33:14 gustavoz Exp $

inherit java-pkg

At="pg73jdbc3.jar"
S=${WORKDIR}
DESCRIPTION="JDBC3 Driver for PostgreSQL"
SRC_URI="http://jdbc.postgresql.org/download/${At}"
HOMEPAGE="http://jdbc.postgresql.org/"
KEYWORDS="x86 amd64 ppc"
IUSE=""
LICENSE="POSTGRESQL"
SLOT="1"
DEPEND=""
RDEPEND=">=virtual/jre-1.4"

src_install() {
	java-pkg_dojar ${DISTDIR}/${At}
}
