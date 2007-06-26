# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-1.2-r2.ebuild,v 1.8 2007/06/26 01:46:36 mr_bones_ Exp $

JAVA_PKG_IUSE="doc javamail jms source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="An easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/v${PV}/LogKit-${PV}-src.tar.gz"
COMMON_DEP="
	javamail? (
		dev-java/sun-jaf
		dev-java/sun-javamail
	)
	jms? ( dev-java/sun-jms )"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEP}"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/LogKit-${PV}"

src_unpack() {
	unpack ${A}
	rm -rf "${S}/src/test/org"
	cd "${S}/lib"

	if use javamail; then
		java-pkg_jar-from sun-jaf
		java-pkg_jar-from sun-javamail
	fi

	use jms && java-pkg_jar-from sun-jms

}

src_compile() {
	# not generating api docs because we would
	# need avalon-site otherwise
	eant jar
}

src_install() {
	java-pkg_dojar ${S}/build/lib/*.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
