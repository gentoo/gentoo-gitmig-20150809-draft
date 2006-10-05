# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-firebird/jdbc2-firebird-1.5.3.ebuild,v 1.9 2006/10/05 17:24:43 gustavoz Exp $

inherit java-pkg

At="FirebirdSQL-${PV}JDK_1.3"
DESCRIPTION="JDBC2 driver for Firebird SQL server"
HOMEPAGE="http://www.firebird.sourceforge.net"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
S=${WORKDIR}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dojar lib/*.jar

	use doc && java-pkg_dohtml -r docs/
	dodoc ChangeLog release_notes.html
}
