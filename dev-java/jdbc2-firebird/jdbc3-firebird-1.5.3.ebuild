# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc2-firebird/jdbc3-firebird-1.5.3.ebuild,v 1.1 2004/10/20 12:27:10 absinthe Exp $

inherit java-pkg

At="FirebirdSQL-${PV}JDK_1.4"
DESCRIPTION="JDBC3 driver for Firebird SQL server"
HOMEPAGE="http://www.firebird.sourceforge.net"
SRC_URI="mirror://sourceforge/firebird/${At}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jdk-1.4"
S=${WORKDIR}

src_compile() {
	:;
}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dojar lib/*.jar

	use doc && java-pkg_dohtml -r docs/
	dodoc ChangeLog release_notes.html
}
