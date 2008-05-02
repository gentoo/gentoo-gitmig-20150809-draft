# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mssqlserver/jdbc-mssqlserver-2005.1.2.2828.100.ebuild,v 1.4 2008/05/02 13:31:55 maekke Exp $

inherit versionator java-pkg-2

DESCRIPTION="JDBC driver for Microsoft SQL Server 2005"
HOMEPAGE="http://www.microsoft.com/downloads/details.aspx?familyid=07287b11-0502-461a-b138-2aa54bfdc03a&displaylang=en"
MY_PN=sqljdbc
MY_PV=$(get_version_component_range 2-)
SRC_URI="http://download.microsoft.com/download/C/D/3/CD301BF5-E28F-45EA-A1DA-53F2EB448D78/${MY_PN}_${MY_PV}_enu.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="MSjdbcEULA2005"
SLOT="2005"

IUSE="doc"

DEPEND=""
RDEPEND=">=virtual/jre-1.4"

RESTRICT="mirror"

S=${WORKDIR}/${MY_PN}_$(get_version_component_range 2-3)/enu

src_install() {
	dodoc release.txt || die
	if use doc; then
		dohtml -r help/*
	fi
	java-pkg_dojar *.jar
}
