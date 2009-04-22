# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antenna/antenna-0.9.14.ebuild,v 1.2 2009/04/22 20:09:05 maekke Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

MY_P=${DISTDIR}/${PN}-src-${PV}.zip

DESCRIPTION="Ant task for J2ME"
HOMEPAGE="http://antenna.sourceforge.net/"
SRC_URI="mirror://sourceforge/antenna/${PN}-src-${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	>=dev-java/ant-core-1.7.0
	~dev-java/servletapi-2.4"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}"

# Don't rewrite samples
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir tmpclasses
	java-ant_bsfix_one build.xml
	java-ant_rewrite-classpath build.xml
}

# http://sourceforge.net/tracker/index.php?func=detail&aid=1716392&group_id=67420&atid=517828
# Build system should be saner if this patch gets accepted
src_compile() {
	EANT_GENTOO_CLASSPATH="ant-core,servletapi-2.4" \
		EANT_BUILD_TARGET="compile package" \
		EANT_DOC_TARGET="" java-pkg-2_src_compile
	if use doc; then
		javadoc -encoding latin1 -d api $(find src -name "*.java") \
			-classpath $(java-pkg_getjars ant-core,servletapi-2.4) || die "javadoc failed"
	fi
}

src_install() {
	java-pkg_newjar dist/${PN}-bin-${PV}.jar
	java-pkg_register-ant-task

	if use doc; then
		java-pkg_dohtml doc/*
		java-pkg_dojavadoc api
	fi
	use source && java-pkg_dosrc src/*
	use examples && java-pkg_doexamples samples
}
