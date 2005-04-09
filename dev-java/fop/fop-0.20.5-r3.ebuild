# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop/fop-0.20.5-r3.ebuild,v 1.1 2005/04/09 14:12:13 luckyduck Exp $

inherit eutils java-pkg

MY_V=${PV/_/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="mirror://apache/xml/fop/fop-${MY_V}-src.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples jai jimi" # jikes support currently not possible :/
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5.4
	!dev-java/fop-bin"
RDEPEND=">=virtual/jre-1.4
	jai? ( dev-java/sun-jai-bin )
	jimi? ( dev-java/sun-jimi )
	=dev-java/avalon-framework-4.1*
	~dev-java/batik-1.5
	dev-java/xalan
	~dev-java/xerces-2.6.2"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-buildxml.patch
	epatch ${FILESDIR}/${PV}-startscript.patch

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from avalon-framework-4.1
	java-pkg_jar-from batik-1.5 batik-all.jar batik.jar
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	use jai && java-pkg_jar-from sun-jai-bin
	use jimi && java-pkg_jar-from sun-jimi
}

src_compile() {
	local antflags="package"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile failed"
}

src_install () {
	java-pkg_dojar build/fop.jar

	newbin fop.sh fop

	if use doc; then
		dodoc CHANGES STATUS README LICENSE
		java-pkg_dohtml -r ReleaseNotes.html build/javadocs/*
	fi

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -ar examples ${D}/usr/share/doc/${PF}/examples
	fi
}
