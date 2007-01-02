# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-1.2-r2.ebuild,v 1.3 2007/01/02 04:55:50 ticho Exp $

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
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"

# Doesn't like 1.6 changes to JDBC
DEPEND="|| (
		=virtual/jdk-1.3*
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	dev-java/ant-core
	dev-java/junit
	source? ( app-arch/zip )
	${COMMON_DEP}"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 x86"
IUSE="doc javamail jms source"

S="${WORKDIR}/LogKit-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"
	rm -f *.jar

	if use javamail; then
		java-pkg_jar-from sun-jaf
		java-pkg_jar-from sun-javamail
	fi

	use jms && java-pkg_jar-from sun-jms
}

src_compile() {
	# not generating api docs because we would
	# need avalon-site otherwise
	eant jar -Djunit.jar=$(java-pkg_getjar --build-only junit junit.jar)
}

src_install() {
	java-pkg_dojar ${S}/build/lib/*.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
