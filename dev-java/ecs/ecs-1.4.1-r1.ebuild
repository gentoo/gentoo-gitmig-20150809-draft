# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecs/ecs-1.4.1-r1.ebuild,v 1.5 2005/04/02 18:26:00 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Java library to generate markup language text such as HTML and XML."
HOMEPAGE="http://jakarta.apache.org/ecs"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ecs/release/v${PV}/${PN}-${PV}.tar.gz"
LICENSE="Apache-1.1"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3
	=dev-java/jakarta-regexp-1.3*
	>=dev-java/xerces-2.6.2-r1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc jikes source"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces.jar
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar regexp.jar
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -f build/build-ecs.xml ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar bin/*.jar

	if use doc; then
		dodoc AUTHORS  COPYING  ChangeLog  INSTALL  README
		java-pkg_dohtml -r docs/*
	fi
	use source && java-pkg_dosrc src/java/*
}
