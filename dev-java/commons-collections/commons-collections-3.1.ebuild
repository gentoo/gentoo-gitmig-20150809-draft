# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-collections/commons-collections-3.1.ebuild,v 1.12 2006/10/05 15:19:58 gustavoz Exp $

inherit java-pkg eutils

DESCRIPTION="Jakarta-Commons Collections Component"
HOMEPAGE="http://jakarta.apache.org/commons/collections/"
SRC_URI="mirror://apache/jakarta/commons/collections/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc amd64 ppc64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	#when this is installed as a dep on ant
	#junit ant task is not installed yet. so it cannot run
	#use junit && antflags="${antflags} test"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc README.txt
	java-pkg_dohtml *.html
	use doc && java-pkg_dohtml -r build/docs/apidocs
	use source && java-pkg_dosrc src/java/*
}
