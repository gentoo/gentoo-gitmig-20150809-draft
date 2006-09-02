# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-8.4b.ebuild,v 1.5 2006/09/02 13:40:52 blubb Exp $

inherit java-pkg eutils

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
MyPV=${PV%b}
SRC_URI="mirror://sourceforge/saxon/saxonb${MyPV/./-}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	>=dev-java/gnu-jaxp-1.3
	dev-java/xom
	~dev-java/jdom-1.0"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )
	${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	unzip -q source.zip || die "failed to unpack"
	mkdir src
	mv net src

	epatch ${FILESDIR}/${P}-jikes.patch

	cp ${FILESDIR}/build-${PVR}.xml build.xml

	rm  *.jar
	mkdir lib && cd lib
	java-pkg_jarfrom gnu-jaxp
	java-pkg_jarfrom jdom-1.0
	java-pkg_jarfrom xom
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api doc/*
	use source && java-pkg_dosrc src/*
}
