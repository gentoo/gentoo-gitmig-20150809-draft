# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-6.5.2.ebuild,v 1.3 2006/01/08 05:17:13 nichoj Exp $

inherit java-pkg eutils versionator

MY_P="${PN}$(replace_all_version_separators _)"
DESCRIPTION="A collection of tools for processing XML documents: XSLT processor, XSL library, parser."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"

LICENSE="MPL-1.1"
SLOT="6.5"
KEYWORDS="~ppc ~x86"

IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	>=dev-java/gnu-jaxp-1.3
	dev-java/xom
	~dev-java/jdom-1.0
	dev-java/fop"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	unzip -qq source.zip -d src || die "failed to unpack"

	cp ${FILESDIR}/build-${PVR}.xml build.xml

	rm  *.jar
	mkdir lib && cd lib
	java-pkg_jarfrom gnu-jaxp
	java-pkg_jarfrom jdom-1.0
	java-pkg_jarfrom xom
	java-pkg_jarfrom fop
}

src_compile() {
	local antflags="jar -Dproject.name=${PN}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api doc/*
	use source && java-pkg_dosrc src/*
}
