# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc3-firebird/jdbc3-firebird-1.5.3-r1.ebuild,v 1.1 2005/12/13 05:38:20 nichoj Exp $

inherit java-pkg

At="FirebirdSQL-${PV}JDK_1.4"
DESCRIPTION="JDBC3 driver for Firebird SQL server"
HOMEPAGE="http://firebird.sourceforge.net"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}

src_install() {
	java-pkg_dojar *.jar

	use doc && java-pkg_dohtml -r docs/
	dodoc ChangeLog release_notes.html
}
