# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmd/pmd-3.8-r1.ebuild,v 1.2 2006/12/09 09:31:36 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java source code analyzer. It finds unused variables, empty catch blocks, unnecessary object creation and so forth."
HOMEPAGE="http://pmd.sourceforge.net"
SRC_URI="mirror://sourceforge/pmd/${PN}-src-${PV}.zip"
LICENSE="pmd"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc source test"

CDEPEND="=dev-java/jaxen-1.1*
	=dev-java/xml-commons-external-1.3*
	>=dev-java/xerces-2.7
	=dev-java/jakarta-oro-2.0*"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	=dev-java/junit-3*
	!test? ( dev-java/ant-core )
	test? ( dev-java/ant )
	source? ( app-arch/zip )
	${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"

	rm -rf docs/apidocs docs/cgi docs/clover docs/xref*
	cd lib
	rm -f *.jar
	java-pkg_jar-from jaxen-1.1
	java-pkg_jar-from xerces-2 xercesImpl.jar
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar
	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from --build-only junit
}

src_compile() {
	cd "${S}/bin"
	eant jar $(use_doc)
}

src_test() {
	cd "${S}/bin"
	eant test
}

src_install() {
	java-pkg_newjar lib/${P}.jar
	dodir /usr/share/ant-core/lib/
	dosym /usr/share/${PN}/lib/${PN}.jar /usr/share/ant-core/lib/${PN}.jar

	java-pkg_dolauncher ${PN} --main net.sourceforge.pmd.PMD \
		-pre "${FILESDIR}/${PN}-pre" --java_args -Xmx512m
	java-pkg_dolauncher ${PN}-designer \
		--main net.sourceforge.pmd.util.designer.Designer
	cp -r rulesets ${D}/usr/share/${PN}

	dodoc etc/readme.txt etc/changelog.txt

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/net
}

pkg_postinst() {
	einfo ""
	einfo "Example rulesets can be found under"
	einfo "/usr/share/pmd/rulesets/"
	einfo ""
}
