# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sax/sax-2.2.1-r1.ebuild,v 1.2 2006/09/12 18:00:53 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="SAX is the Simple API for XML, originally a Java-only API. SAX was the first widely adopted API for XML in Java."

HOMEPAGE="http://sax.sourceforge.net/"
SRC_URI="mirror://sourceforge/sax/sax2r3.zip"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip
		dev-java/ant"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/sax2r3

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf classes *.jar
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_newjar sax2.jar ${PN}.jar
	dodoc ChangeLog CHANGES README

	use doc && java-pkg_dohtml -r docs/javadoc/*
	use source && java-pkg_dosrc ${S}/src/*
}
