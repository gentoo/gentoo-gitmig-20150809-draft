# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecs/ecs-1.4.1.ebuild,v 1.4 2004/01/14 04:02:10 strider Exp $

S=${WORKDIR}/${P/jakarta-/}
DESCRIPTION="Java library to generate markup language text such as HTML and XML."
HOMEPAGE="http://jakarta.apache.org/ecs"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ecs/release/v${PV}/${PN}-${PV}.tar.gz"
LICENSE="Apache-1.1"
DEPEND="virtual/jdk
	>=dev-java/ant-1.4"
RDEPEND="virtual/jdk"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	ant -f build/build-ecs.xml
}

src_install() {
	dojar bin/*.jar
	dohtml -r docs/*
	dodoc AUTHORS  COPYING  ChangeLog  INSTALL  README
}
