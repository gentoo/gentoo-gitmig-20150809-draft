# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcs-bin/jcs-bin-1.2.5.ebuild,v 1.4 2005/07/16 10:19:54 axxo Exp $

inherit java-pkg

DESCRIPTION="JCS is a distributed caching system"
SRC_URI="http://cvs.apache.org/viewcvs.cgi/*checkout*/jakarta-turbine-jcs/tempbuild/jcs-1.2.5-dev.jar"
HOMEPAGE="http://jakarta.apache.org/jcs"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="x86 amd64"
DEPEND=""
RDEPEND=">=virtual/jre-1.3"
IUSE=""

src_unpack() { :; }

src_install() {
	java-pkg_newjar ${DISTDIR}/${P//-bin}-dev.jar jcs.jar
}
