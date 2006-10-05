# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-1.2.ebuild,v 1.26 2006/10/05 15:07:04 gustavoz Exp $

inherit java-pkg

DESCRIPTION="LogKit is an easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/v${PV}/LogKit-${PV}-src.tar.gz"
RDEPEND=">=virtual/jre-1.3
	javamail? (
		dev-java/sun-jaf-bin
		|| (
			dev-java/sun-javamail-bin
			=dev-java/gnu-javamail-1.0*
		)
	)
	jms? ( || (
			!ppc? ( dev-java/openjms )
			dev-java/sun-jms
		)
	)"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	dev-java/junit
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )
	${RDEPEND}"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="x86 amd64 ppc64 ppc"
IUSE="doc javamail jikes jms source"

S=${WORKDIR}/LogKit-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm -f *.jar

	# decide which mail implementation we use
	if use javamail; then
		java-pkg_jar-from sun-jaf-bin

		if has_version dev-java/gnu-javamail; then
			java-pkg_jar-from gnu-javamail-1
		elif has_version dev-java/sun-javamail-bin; then
			java-pkg_jar-from sun-javamail-bin
		fi
	fi

	# decide which jms implementation we use
	if use jms; then
		if has_version dev-java/openjms; then
			java-pkg_jar-from openjms
		elif has_version dev-java/sun-jms; then
			java-pkg_jar-from sun-jms
		fi
	fi
}

src_compile() {
	# not generating api docs because we would 
	# need avalon-site otherwise
	local antflags="jar -Djunit.jar=$(java-pkg_getjar junit junit.jar)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar ${S}/build/lib/*.jar || die "Unable to Install"
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/java/*
}
