# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sax/sax-2.2.1.ebuild,v 1.5 2004/11/03 11:37:20 axxo Exp $

inherit java-pkg

DESCRIPTION="SAX is the Simple API for XML, originally a Java-only API. SAX was the first widely adopted API for XML in Java."

HOMEPAGE="http://sax.sourceforge.net/"
SRC_URI="mirror://sourceforge/sax/sax2r3.zip"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="virtual/jdk
		app-arch/unzip
		dev-java/ant"
RDEPEND="virtual/jre"

S=${WORKDIR}/sax2r3

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf classes *.jar
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "failed to compile"
	mv sax2.jar sax.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc ChangeLog CHANGES README

	use doc && java-pkg_dohtml -r docs/javadoc/*
}
