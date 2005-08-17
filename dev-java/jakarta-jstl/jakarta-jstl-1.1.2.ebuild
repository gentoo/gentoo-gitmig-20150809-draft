# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-jstl/jakarta-jstl-1.1.2.ebuild,v 1.4 2005/08/17 19:19:38 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="An implementation of the JSP Standard Tag Library (JSTL)"
HOMEPAGE="http://jakarta.apache.org/taglibs/doc/standard-doc/intro.html"
SRC_URI="mirror://apache/jakarta/taglibs/standard/source/jakarta-taglibs-standard-${PV}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc jikes examples source"

RDEPEND=">=virtual/jre-1.4.2
	>=www-servers/tomcat-5
	=dev-java/servletapi-2.4*"
DEPEND=">=virtual/jdk-1.4.2
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S=${WORKDIR}/jakarta-taglibs-standard-${PV}-src/standard

src_unpack() {
	unpack ${A}
	cd ${S}

	echo -e "base.dir=..\n" \
		 "build.dir = \${base.dir}/build\n" \
		 "build.classes=\${build.dir}/standard/standard/classes\n" \
		 "dist.dir = \${base.dir}/dist\n" \
		 "servlet24.jar=$(java-pkg_getjar servletapi-2.4 servlet-api.jar)\n" \
		 "jsp20.jar=$(java-pkg_getjar servletapi-2.4 jsp-api.jar)\n" \
		 > build.properties
}

src_compile() {
	local antflags="build"
	use doc && antflags="${antflags} javadoc-dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar ${S}/../build/standard/standard/lib/*.jar

	use doc && java-pkg_dohtml -r ${S}/doc/web/* ${S}/../dist/standard/javadoc/
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc ${S}/src/*
}
