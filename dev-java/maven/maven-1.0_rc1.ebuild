# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven/maven-1.0_rc1.ebuild,v 1.2 2003/11/20 12:00:56 strider Exp $

S="${WORKDIR}/maven-1.0-rc1"
DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="http://maven.apache.org/builds/release/1.0-rc1/maven-1.0-rc1.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-1.1"
SLOT="1.0"
KEYWORDS="x86"
PROVIDE="dev-java/maven"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /usr/share/maven
	dodir /usr/lib/java
	exeinto /usr/bin
	doexe ${S}/bin/maven
	insinto /etc/env.d
	doins ${FILESDIR}/25maven
	cp -Rdp * ${D}/usr/share/maven
}
