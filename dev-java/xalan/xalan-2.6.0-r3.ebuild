# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xalan/xalan-2.6.0-r3.ebuild,v 1.5 2007/01/03 14:28:08 caster Exp $

inherit java-pkg eutils

MY_P=${PN}-j_${PV//./_}
DESCRIPTION="XSLT processor"
HOMEPAGE="http://xml.apache.org/xalan-j/index.html"
SRC_URI="mirror://apache/xml/xalan-j/source/${MY_P}-src.tar.gz
		doc? ( mirror://gentoo/${P}-docs.tar.bz2 )"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc jikes source"
RDEPEND="=virtual/jdk-1.4*
	dev-java/javacup
	dev-java/bcel
	=dev-java/jakarta-regexp-1.3*
	=dev-java/bsf-2.3*
	>=dev-java/xerces-2.6.2-r1"
DEPEND="=virtual/jdk-1.4*
	>=dev-java/ant-core-1.5.2
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/bin
	rm -f *.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from javacup javacup.jar java_cup.jar
	java-pkg_jar-from javacup javacup.jar runtime.jar
	java-pkg_jar-from bcel bcel.jar BCEL.jar
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar regexp.jar
	java-pkg_jar-from bsf-2.3
	#java-pkg_jar-from jtidy
	#java-pkg_jar-from jlex jlex.jar JLex.jar
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "build failed"
}

src_install() {
	java-pkg_dojar build/xalan.jar
	use doc && java-pkg_dohtml -r ${WORKDIR}/docs/*
	use source && java-pkg_dosrc src/org

	newbin ${FILESDIR}/${PN}.script ${PN}
}
