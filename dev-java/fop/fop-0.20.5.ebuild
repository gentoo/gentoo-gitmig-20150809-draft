# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop/fop-0.20.5.ebuild,v 1.11 2004/10/17 21:44:41 axxo Exp $

inherit java-pkg

MY_V=${PV/_/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="mirror://apache/xml/fop/fop-${MY_V}-src.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	jai? ( dev-java/jai-bin )
	jimi? ( dev-java/jimi )
	>=dev-java/ant-1.5.4
	!dev-java/fop-bin"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	jai && java-pkg_jar-from jai-bin
	jimi && java-pkg_jar-from jimi
}

src_compile() {
	ant package || die "Failed building classes"

	if use doc; then
		ant javadocs || die "Failed building javadocs"
	fi
}

src_install () {
	sed '2itest "$FOP_HOME" || FOP_HOME=/usr/share/fop/' fop.sh > fop
	java-pkg_dojar build/*.jar
	java-pkg_dojar lib/*.jar

	exeinto /usr/bin
	doexe fop

	if use doc; then
		dodoc CHANGES STATUS README LICENSE
		dohtml ReleaseNotes.html
		dodir /usr/share/doc/${P}
		cp -a examples ${D}/usr/share/doc/${P}
		java-pkg_dohtml -r build/javadocs
	fi
}
