# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-jstl/jakarta-jstl-1.1.2-r1.ebuild,v 1.7 2007/08/15 09:41:32 opfer Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PN="jakarta-taglibs-standard"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="An implementation of the JSP Standard Tag Library (JSTL)"
HOMEPAGE="http://jakarta.apache.org/taglibs/doc/standard-doc/intro.html"
SRC_URI="mirror://apache/jakarta/taglibs/standard/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 x86 ~x86-fbsd"
IUSE="doc examples source"

COMMON_DEP="~dev-java/servletapi-2.4
	dev-java/xalan"
RDEPEND=">=virtual/jre-1.4.2
	${COMMON_DEP}"
# FIXME breaks due to new JDBC API in 1.6
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	${COMMON_DEP}
	dev-java/ant-core
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}-src/standard"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Remove unnecessary bootclasspath from javac calls.
	# This allows compilation with  non-Sun JDKs
	# See bug #134206
	# TODO file upstream
	epatch ${FILESDIR}/build-xml.patch

	echo -e "base.dir=..\n" \
		"build.dir = \${base.dir}/build\n" \
		"build.classes=\${build.dir}/standard/standard/classes\n" \
		"dist.dir = \${base.dir}/dist\n" \
		"servlet24.jar=$(java-pkg_getjar servletapi-2.4 servlet-api.jar)\n" \
		"jsp20.jar=$(java-pkg_getjar servletapi-2.4 jsp-api.jar)\n" \
		"xalan.jar=$(java-pkg_getjar xalan xalan.jar)" \
		> build.properties
}

src_compile() {
	eant build $(use_doc javadoc-dist)
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
