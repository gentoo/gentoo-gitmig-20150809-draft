# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.3-r1.ebuild,v 1.1 2003/04/18 08:05:42 absinthe Exp $

S="${WORKDIR}/apache-ant-${PV}-1"
DESCRIPTION="Build system for Java"
SRC_URI="http://www.apache.org/dist/ant/binaries/apache-ant-${PV}-1-bin.tar.bz2"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_install() {
	cd ${S}
	mkdir ${S}/src
	cp ${FILESDIR}/${PV}/ant ${S}/src/ant
	exeinto /usr/bin
	doexe src/ant
	dojar lib/*.jar lib/*.jar
	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && dohtml -r docs/*
}
