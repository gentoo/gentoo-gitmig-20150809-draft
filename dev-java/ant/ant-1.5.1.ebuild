# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.1.ebuild,v 1.1 2002/10/25 23:47:41 blizzy Exp $

S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ant/release/v${PV}/src/jakarta-ant-${PV}-src.tar.gz"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"

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
