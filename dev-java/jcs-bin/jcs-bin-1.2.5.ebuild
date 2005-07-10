# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcs-bin/jcs-bin-1.2.5.ebuild,v 1.3 2005/07/10 19:12:07 agriffis Exp $

inherit java-pkg

DESCRIPTION="JCS is a distributed caching system"
SRC_URI="http://cvs.apache.org/viewcvs.cgi/*checkout*/jakarta-turbine-jcs/tempbuild/jcs-1.2.5-dev.jar"
HOMEPAGE="http://jakarta.apache.org/jcs"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="x86 amd64"
DEPEND=">=virtual/jre-1.3"
RDEPEND=">=virtual/jre-1.3"
IUSE=""

src_unpack() {
	einfo "Nothing to unpack"
}

src_install() {
	mkdir -p ${S}
	cd ${S}
	cp ${DISTDIR}/jcs-1.2.5-dev.jar ${S}/jcs.jar
	java-pkg_dojar jcs.jar
}
