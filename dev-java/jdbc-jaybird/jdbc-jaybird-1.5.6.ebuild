# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-jaybird/jdbc-jaybird-1.5.6.ebuild,v 1.2 2007/01/05 00:35:58 wltjr Exp $

inherit java-pkg-2

MY_P="FirebirdSQL-${PV}JDK_1.4"
DESCRIPTION="JDBC Type 4 driver for Firebird SQL server"
HOMEPAGE="http://jaybirdwiki.firebirdsql.org/"
SRC_URI="mirror://sourceforge/firebird/${MY_P}.zip"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5 )
	app-arch/unzip"
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.5 )"
S=${WORKDIR}

src_install() {
	java-pkg_dojar *.jar

	use doc && java-pkg_dohtml -r docs/
	dodoc ChangeLog release_notes.html
}
