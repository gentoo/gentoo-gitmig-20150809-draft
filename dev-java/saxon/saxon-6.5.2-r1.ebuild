# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-6.5.2-r1.ebuild,v 1.1 2006/07/02 19:37:47 nichoj Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
# TODO use versionator?
SRC_URI="mirror://sourceforge/saxon/saxon${PV//./_}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"

LICENSE="MPL-1.1"
SLOT="6.5"
KEYWORDS="~ppc ~x86"

IUSE="doc source"

COMMOND_DEP=">=dev-java/gnu-jaxp-1.3
	dev-java/xom
	~dev-java/jdom-1.0
	dev-java/fop"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"

DEPEND="=virtual/jdk-1.4*
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

S="${WORKDIR}"

ant_src_unpack() {
	unpack ${A}

	unzip -qq source.zip -d src || die "failed to unpack"

	# TODO update patch for 6.5.2
	#epatch ${FILESDIR}/${P}-jikes.patch

	cp ${FILESDIR}/build-${PV}.xml build.xml

	rm  *.jar
	mkdir lib && cd lib
	java-pkg_jarfrom gnu-jaxp
	java-pkg_jarfrom jdom-1.0
	java-pkg_jarfrom xom
	java-pkg_jarfrom fop
}

src_compile() {
	java-pkg_filter-compiler jikes

	eant jar -Dproject.name=${PN} $(use_doc)
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api doc/*
	use source && java-pkg_dosrc src/*
}
