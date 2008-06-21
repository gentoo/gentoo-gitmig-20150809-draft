# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/zemberek/zemberek-2.1_rc1.ebuild,v 1.1 2008/06/21 11:51:50 serkan Exp $

EAPI=1
JAVA_PKG_IUSE="source doc"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Zemberek NLP library"
HOMEPAGE="http://code.google.com/p/zemberek/"
SRC_URI="http://${PN}.googlecode.com/files/${P}-src.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LANGS="tr tk"

S=${WORKDIR}/${P}-src

IUSE="linguas_tk +linguas_tr"

RDEPEND=">=virtual/jre-1.5"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	rm -v "${S}"/lib/gelistirme/*.jar || die
}

src_compile() {
	strip-linguas ${LANGS}
	local anttargs
	for jar in cekirdek demo ${LINGUAS}; do
		anttargs="${anttargs} jar-${jar}"
	done
	eant ${anttargs} $(use_doc javadocs)
}

src_install() {
	strip-linguas ${LANGS}
	local sourcetrees=""
	for jar in cekirdek demo ${LINGUAS}; do
		java-pkg_newjar dagitim/jar/zemberek-${jar}-${PV}.jar zemberek2-${jar}.jar
		sourcetrees="${sourcetrees} src/${jar}/net"
	done
	use source && java-pkg_dosrc ${sourcetrees}
	use doc && java-pkg_dojavadoc build/java-docs/api
	java-pkg_dolauncher zemberek-demo --main net.zemberek.demo.DemoMain
	dodoc dokuman/lisanslar/* || die
	dodoc surumler.txt || die
}
