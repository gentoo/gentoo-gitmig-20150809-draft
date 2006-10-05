# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fop/fop-0.20.5-r1.ebuild,v 1.6 2006/10/05 15:42:07 gustavoz Exp $

inherit java-pkg

MY_V=${PV/_/}
DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
SRC_URI="mirror://apache/xml/fop/fop-${MY_V}-src.tar.gz"
HOMEPAGE="http://xml.apache.org/fop/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jai jimi"
RDEPEND=">=virtual/jre-1.4
	jai? ( dev-java/sun-jai-bin )
	jimi? ( dev-java/sun-jimi )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-1.5.4
	!dev-java/fop-bin"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	use jai && java-pkg_jar-from sun-jai-bin
	use jimi && java-pkg_jar-from sun-jimi
}

src_compile() {
	ant package || die "Failed building classes"

	if use doc; then
		ant javadocs || die "Failed building javadocs"
	fi
}

src_install() {
	sed '2itest "$FOP_HOME" || FOP_HOME=/usr/share/fop/' fop.sh > fop
	java-pkg_dojar build/*.jar

	exeinto /usr/bin
	doexe fop

	if use doc; then
		dodoc CHANGES STATUS README
		dohtml ReleaseNotes.html
		dodir /usr/share/doc/${P}
		cp -a examples ${D}/usr/share/doc/${P}
		java-pkg_dohtml -r build/javadocs
	fi
}
