# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit/avalon-logkit-1.2.ebuild,v 1.15 2005/04/03 17:06:33 luckyduck Exp $


inherit java-pkg

DESCRIPTION="LogKit is an easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/v${PV}/LogKit-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	dev-java/junit
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3
	javamail? (
		dev-java/sun-jaf-bin
		|| (
			dev-java/sun-javamail-bin
			dev-java/gnu-javamail
		)
	)
	jms? ( || (
			dev-java/openjms
			dev-java/jms
		)
	)"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc"
IUSE="doc javamail jikes jms"

S=${WORKDIR}/LogKit-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	# decide which mail implementation we use
	if use javamail; then
		java-pkg_jar-from sun-jaf-bin

		if has_version gnu-javamail; then
			java-pkg_jar-from gnu-javamail
		elif has_version sun-javamail-bin; then
			java-pkg_jar-from sun-javamail-bin
		fi
	fi

	# decide which jms implementation we use
	if use jms; then
		if has_version openjms; then
			java-pkg_jar-from openjms
		elif has_version jms; then
			java-pkg_jar-from jms
		fi
	fi
}

src_compile() {
	# not generating api docs because we would 
	# need avalon-site otherwise
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install () {
	java-pkg_dojar ${S}/build/lib/*.jar || die "Unable to Install"
	use doc && java-pkg_dohtml -r docs/*
}
