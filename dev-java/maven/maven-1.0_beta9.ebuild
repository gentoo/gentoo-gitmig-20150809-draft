# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven/maven-1.0_beta9.ebuild,v 1.1 2003/04/23 06:16:50 strider Exp $

S="${WORKDIR}/maven-1.0-beta-9"
DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="http://maven.apache.org/builds/release/1.0-beta-9/maven-1.0-beta-9.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-1.1"
ARCH="~x86"
SLOT="0"
KEYWORDS="~x86"
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
