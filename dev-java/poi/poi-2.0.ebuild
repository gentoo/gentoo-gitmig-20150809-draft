# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/poi/poi-2.0.ebuild,v 1.2 2004/03/23 03:25:27 zx Exp $

inherit java-pkg

DESCRIPTION="Java API To Access Microsoft Format Files"
HOMEPAGE="http://jakarta.apache.org/poi/"
SRC_URI="http://apache.towardex.com/jakarta/poi/release/src/${PN}-src-${PV}-final-20040126.tar.gz"
IUSE="jikes"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=virtual/jdk-1.2
		>=dev-java/ant-1.4"
RDEPEND=">=virtual/jdk-1.2
		dev-java/junit
		dev-java/xerces
		dev-java/jdepend
		dev-java/xalan
		dev-java/commons-logging
		dev-java/log4j
		dev-java/commons-beanutils
		dev-java/commons-collections
		dev-java/commons-lang"

S=${WORKDIR}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar build/dist/*.jar
}
