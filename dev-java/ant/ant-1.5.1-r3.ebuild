# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.5.1-r3.ebuild,v 1.1 2002/12/02 00:55:23 strider Exp $

S=${WORKDIR}/jakarta-ant-${PV}
DESCRIPTION="Build system for Java"
SRC_URI="mirror://gentoo/jakarta-ant-${PV}-bin.tar.bz2"
HOMEPAGE="http://jakarta.apache.org"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"
IUSE=""

src_install() {
	mkdir src
	cp ${FILESDIR}/${PV}/ant src/ant
	exeinto /usr/bin
	doexe src/ant
	dojar lib/*.jar lib/*.jar
	dodoc LICENSE LICENSE.* README WHATSNEW KEYS
	dohtml welcome.html
	dohtml -r docs/*
}
