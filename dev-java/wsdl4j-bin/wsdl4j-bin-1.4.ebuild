# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j-bin/wsdl4j-bin-1.4.ebuild,v 1.3 2004/10/22 10:32:14 absinthe Exp $

inherit java-pkg

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
MY_PN="wsdl4j-bin"
MY_P="${MY_PN}-${PV}"
SRC_URI="ftp://www-126.ibm.com/pub/${PN/-bin}/WSDL4J/${PV}/${MY_P}.zip"
HOMEPAGE="http://www-124.ibm.com/developerworks/projects/wsdl4j"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="CPL-1.0"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.4"
IUSE=""
S="${WORKDIR}/${PN/-bin}-${PV//./_}"

src_compile() { :; }

src_install() {
	java-pkg_dohtml -r docs/
	java-pkg_dojar lib/qname.jar lib/wsdl4j.jar
}
