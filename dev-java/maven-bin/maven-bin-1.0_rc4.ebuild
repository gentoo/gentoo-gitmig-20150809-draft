# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven-bin/maven-bin-1.0_rc4.ebuild,v 1.3 2004/10/29 12:56:51 axxo Exp $

DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="mirror://apache/maven/binaries/${PN/-bin}-${PV/_/-}.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""

S="${WORKDIR}/${PN/-bin}-${PV/_/-}"

src_compile() { :; }

src_install() {
	dodir /usr/share/maven
	dodir /usr/lib/java
	exeinto /usr/bin
	doexe ${S}/bin/maven
	insinto /etc/env.d
	doins ${FILESDIR}/25maven
	cp -Rdp * ${D}/usr/share/maven
}
