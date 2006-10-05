# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/servletapi/servletapi-2.4-r2.ebuild,v 1.5 2006/10/05 17:14:27 gustavoz Exp $

inherit eutils java-pkg

DESCRIPTION="Servlet API 2.4 from jakarta.apache.org"
HOMEPAGE="http://jakarta.apache.org/"
SRC_URI="mirror://apache/jakarta/tomcat-5/v5.0.19/src/jakarta-tomcat-5.0.19-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.4"
KEYWORDS="x86 ppc amd64 ppc64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/jakarta-tomcat-5.0.19-src/jakarta-servletapi-5

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-${P}-patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc examples"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} -f jsr154/build.xml || die "compilation problem"
	ant ${antflags} -f jsr152/build.xml || die "compilation problem"
}

src_install() {
	mv jsr{154,152}/dist/lib/*.jar ${S}

	if use doc ; then
		mkdir docs
		cd ${S}/jsr154/build
		mv docs ${S}/docs/servlet
		mv examples ${S}/docs/servlet/examples

		cd ${S}/jsr152/build
		mv docs ${S}/docs/jsp
		mv examples ${S}/docs/jsp/examples
	fi

	cd ${S}
	java-pkg_dojar *.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc jsr{152,154}/src/share/javax
}
