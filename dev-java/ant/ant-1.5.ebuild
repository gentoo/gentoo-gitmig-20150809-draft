# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.ebuild,v 1.1 2002/09/08 15:26:27 karltk Exp $

S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ant/release/v${PV}/src/jakarta-ant-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3
	dev-java/java-config"

src_compile() {
	export JAVA_HOME=${JDK_HOME}
	./build.sh -Ddist.dir=${D}/usr/share/ant || die
}

src_install() {

	cp ${FILESDIR}/${PV}/ant src/ant

	exeinto /usr/bin
	doexe src/ant

	dojar build/lib/*.jar lib/*.jar
	
	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	dohtml welcome.html
	dohtml -r docs/*
}
