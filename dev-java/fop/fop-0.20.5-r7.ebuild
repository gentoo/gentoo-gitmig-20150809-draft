# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop/fop-0.20.5-r7.ebuild,v 1.9 2007/08/29 13:54:37 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

MY_V=${PV/_/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="mirror://apache/xml/fop/fop-${MY_V}-src.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc64 x86"
IUSE="doc examples jai jimi"

# Doesn't like Java 1.5
COMMON_DEP="
	jai? ( dev-java/sun-jai-bin )
	jimi? ( dev-java/sun-jimi )
	=dev-java/avalon-framework-4.1*
	~dev-java/batik-1.5
	dev-java/xalan
	>=dev-java/xerces-2.7
	!dev-java/fop-bin
	>=dev-java/ant-core-1.5.4"
RDEPEND="=virtual/jre-1.4*
	${COMMON_DEP}"
DEPEND="=virtual/jdk-1.4*
	${COMMON_DEP}
	dev-java/ant-trax"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch ${FILESDIR}/${PV}-no-autodetection.patch

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from avalon-framework-4.1
	java-pkg_jar-from batik-1.5 batik-all.jar batik.jar
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	use jai && java-pkg_jar-from sun-jai-bin
	use jimi && java-pkg_jar-from sun-jimi
}

src_compile() {
	java-pkg_filter-compiler jikes

	local jaip jimip

	use jai && jaip="-Djai.present=true"
	use jimi && jimip="-Djimi.present=true"

	ANT_TASKS="ant-trax" eant ${jaip} ${jimip} package $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/fop.jar

	dodir /etc/env.d/java/
	echo 'FOP_HOME=/usr/share/fop/' > ${D}/etc/env.d/java/22fop
	java-pkg_dolauncher ${PN} --main org.apache.fop.apps.Fop

	dodoc CHANGES STATUS README || die
	if use doc; then
		java-pkg_dohtml -r ReleaseNotes.html build/javadocs/*
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -pPR examples ${D}/usr/share/doc/${PF}/examples
	fi
}
