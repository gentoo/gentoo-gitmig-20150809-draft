# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecs/ecs-1.4.1-r1.ebuild,v 1.1 2004/10/26 16:10:10 axxo Exp $

inherit java-pkg

DESCRIPTION="Java library to generate markup language text such as HTML and XML."
HOMEPAGE="http://jakarta.apache.org/ecs"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ecs/release/v${PV}/${PN}-${PV}.tar.gz"
LICENSE="Apache-1.1"
DEPEND="virtual/jdk
	>=dev-java/ant-1.4
	>=dev-java/regexp-1.2
	>=dev-java/xerces-2.6.2-r1"
RDEPEND="virtual/jre"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces.jar
	java-pkg_jar-from regexp
}

src_compile() {
	ant -f build/build-ecs.xml || die "compilation failed"
}

src_install() {
	java-pkg_dojar bin/*.jar
	dodoc AUTHORS  COPYING  ChangeLog  INSTALL  README
	use doc && java-pkg_dohtml -r docs/*
}
