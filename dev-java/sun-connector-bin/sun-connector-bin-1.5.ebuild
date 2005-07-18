# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-connector-bin/sun-connector-bin-1.5.ebuild,v 1.4 2005/07/18 17:07:23 axxo Exp $

inherit java-pkg

DESCRIPTION="The J2EE Connector architecture provides a Java solution to the problem of connectivity between the many application servers and EISs already in existence."
HOMEPAGE="http://java.sun.com/j2ee/connector/index.jsp"
SRC_URI="j2ee_connector-1_5-fr-spec-classes.zip"
LICENSE="sun-bcla-connector"
SLOT=1.5
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=virtual/jre-1.3"
DEPEND="app-arch/unzip"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automagically."
	einfo
	einfo " 1. Visit ${HOMEPAGE} and select 'Downloads'"
	einfo " 2. Select 'J2EE Connector Architecture Specification - 1.5 - Download class file."
	einfo " 3. Download ${A}"
	einfo " 4. Move file to ${DISTDIR}"
	einfo
}
src_install() {
	cd ${WORKDIR}

	java-pkg_dojar connector-api.jar
}

