# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/axion/axion-1.0_rc2-r1.ebuild,v 1.1 2005/03/27 18:20:46 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="Java RDMS with SQL and JDBC"
HOMEPAGE="http://axion.tigris.org/"
SRC_URI="http://axion.tigris.org/releases/1.0M2/axion-1.0-M2-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"
RDEPEND=">=dev-java/commons-collections-2.1
	>=dev-java/commons-primitives-1.0*
	>=dev-java/commons-codec-1.2*
	>=dev-java/log4j-1.2*
	=dev-java/jakarta-regexp-1.3*"
DEPEND="${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )
	source? ( app-arch/zip )
	>=dev-java/ant-1.5.4"

S=${WORKDIR}/${PN}-1.0-M2

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/commons-codec.patch

	mkdir lib test
	(
		cd lib
		java-pkg_jar-from commons-collections || die commons-collections
		java-pkg_jar-from commons-primitives || die commons-primitives
		java-pkg_jar-from commons-logging || die commons-logging
		java-pkg_jar-from commons-codec || die commons-codec
		java-pkg_jar-from log4j || die log4j
		java-pkg_jar-from jakarta-regexp-1.3 || die jakarta-regexp-1.3
	)

	echo javacc.home=/usr/share/javacc/lib \
		> build.properties
}

src_compile() {
	local antflags="compile jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar bin/axion-1.0-M2.jar
	use doc && java-pkg_dohtml -r bin/docs/api
	use source && java-pkg_dosrc src/*
}
