# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-primitives/commons-primitives-1.0.ebuild,v 1.1 2004/03/30 22:11:57 karltk Exp $

inherit java-pkg

DESCRIPTION="The Jakarta-Commons Primitives Component"
HOMEPAGE="http://jakarta.apache.org/commons/primitives/"
SRC_URI="mirror://apache/jakarta/commons/primitives/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	jikes? ( dev-java/jikes )
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes junit"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "junit.jar=`java-config -p junit`" >> build.properties
}

src_compile() {
	local antflags="compile"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_dojar target/${PN}-${PV}.jar

	use doc && dohtml -r target/docs/api/*
}
