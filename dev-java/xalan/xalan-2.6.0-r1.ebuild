# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xalan/xalan-2.6.0-r1.ebuild,v 1.6 2004/10/29 03:14:29 weeve Exp $

inherit java-pkg eutils


MY_P=${PN}-j_${PV//./_}
DESCRIPTION="XSLT processor"
HOMEPAGE="http://xml.apache.org/xalan-j/index.html"
SRC_URI="mirror://apache/xml/xalan-j/source/${MY_P}-src.tar.gz
		doc? ( mirror://gentoo/${P}-docs.tar.bz2 )"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.5.2
	dev-java/javacup
	dev-java/bcel
	>=dev-java/regexp-1.3-r1
	=dev-java/bsf-2.3*
	>=dev-java/xerces-2.6.2-r1"
RDEPEND=">=virtual/jdk-1.3
	>=dev-java/xerces-2.6.0"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/bin
	rm -f *.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from javacup javacup.jar java_cup.jar
	java-pkg_jar-from javacup javacup.jar runtime.jar
	java-pkg_jar-from bcel bcel.jar BCEL.jar
	java-pkg_jar-from regexp
	java-pkg_jar-from bsf-2.3
	#java-pkg_jar-from jtidy
	#java-pkg_jar-from jlex jlex.jar JLex.jar
	cd ${S}
}

src_compile() {
	ant jar || die "build failed"
}

src_install () {
	java-pkg_dojar build/xalan.jar
	use doc && java-pkg_dohtml -r ${WORKDIR}/docs/*
}
