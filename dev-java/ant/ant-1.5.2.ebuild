# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.2.ebuild,v 1.3 2003/04/26 05:36:58 strider Exp $

S=${WORKDIR}/apache-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="mirror://apache/ant/binaries/apache-ant-${PV}-bin.tar.bz2"
HOMEPAGE="http://ant.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_install() {
	mkdir src
	cp ${FILESDIR}/${PV}/ant src/ant
	exeinto /usr/bin
	doexe src/ant
	dojar lib/*.jar lib/*.jar
	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	use doc && dohtml welcome.html
	use doc && dohtml -r docs/*
}
