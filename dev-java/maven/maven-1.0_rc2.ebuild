# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven/maven-1.0_rc2.ebuild,v 1.1 2004/03/27 05:55:02 zx Exp $

DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="mirror://apache/maven/binaries/${PN}-${PV/_/-}.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="~x86"
PROVIDE="dev-java/maven"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""

S="${WORKDIR}/${PN}-${PV/_/-}"

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
