# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-8.4b-r1.ebuild,v 1.1 2006/07/02 19:37:47 nichoj Exp $

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
MyPV=${PV%b}
SRC_URI="mirror://sourceforge/saxon/saxonb${MyPV/./-}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc source"

COMMON_DEP=">=dev-java/gnu-jaxp-1.3
	dev-java/xom
	~dev-java/jdom-1.0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND="=virtual/jdk-1.4*
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

S=${WORKDIR}

ant_src_unpack() {
	unpack ${A}

	unzip -q source.zip || die "failed to unpack"
	mkdir src
	mv net src

	epatch ${FILESDIR}/${P}-jikes.patch

	cp ${FILESDIR}/build-${PV}.xml build.xml

	rm  *.jar
	mkdir lib && cd lib
	java-pkg_jarfrom gnu-jaxp
	java-pkg_jarfrom jdom-1.0
	java-pkg_jarfrom xom
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api doc/*
	use source && java-pkg_dosrc src/*
}
