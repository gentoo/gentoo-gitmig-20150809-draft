# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-2.3.1.ebuild,v 1.5 2008/05/02 09:31:31 opfer Exp $

JAVA_PKG_IUSE="doc"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_beta/b}"

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/JabRef-${MY_PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

CDEPEND="dev-java/spin
	>=dev-java/glazedlists-1.5.0
	>=dev-java/antlr-2.7.3
	>=dev-java/jgoodies-forms-1.1.0
	>=dev-java/jgoodies-looks-2.0
	>=dev-java/microba-0.4.3
	dev-java/jempbox
	dev-java/pdfbox"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# moves jarbundler definition to where it's needed (not by us)
	# don't call unjarlib, don't want to absorb deps
	epatch "${FILESDIR}/${PN}-2.2-build.xml.patch"

	mkdir libs
	mv lib/antlr-3* libs/antlr3.jar
	rm -v lib/*

	java-ant_rewrite-classpath
}

src_compile() {
	java-pkg_filter-compiler jikes

	local gcp=$(java-pkg_getjars antlr,spin,glazedlists,jgoodies-looks-2.0,jgoodies-forms,microba,jempbox,pdfbox)
	gcp="${gcp}:libs/antlr3.jar"
	eant -Dgentoo.classpath="${gcp}" jars \
		$(use_doc -Dbuild.javadocs=build/docs/api javadocs)
}

src_install() {
	java-pkg_newjar build/lib/JabRef-${MY_PV}.jar
	java-pkg_dojar libs/antlr3.jar

	use doc && java-pkg_dojavadoc build/docs/api
	dodoc src/txt/README

	java-pkg_dolauncher ${PN} \
		--main net.sf.jabref.JabRef

	newicon src/images/JabRef-icon-48.png JabRef-icon.png || die
	make_desktop_entry jabref JabRef JabRef-icon Office
}
