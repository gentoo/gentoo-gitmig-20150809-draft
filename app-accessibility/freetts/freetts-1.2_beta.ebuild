# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/freetts/freetts-1.2_beta.ebuild,v 1.3 2004/03/22 20:35:03 zx Exp $

inherit java-pkg eutils

DESCRIPTION="FreeTTS is a speech synthesis system written entirely in the Java programming language"
SRC_URI="mirror://sourceforge/freetts/${PN}-srcs-${PV/./_}.zip"
HOMEPAGE="http://freetts.sourceforge.net"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.6.0
		app-arch/unzip
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="sun-bcla-jsapi freetts"
SLOT="0"
KEYWORDS="~x86 ~ppc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	chmod 755 jsapi.sh
	epatch ${FILESDIR}/jsapi-gentoo.diff
}

src_compile() {
	cd ${S}/lib
	./jsapi.sh >& /dev/null && cd ${S}
	local antflags="jars"
	use doc && unzip -qq javadoc.zip
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar lib/*.jar mbrola/*.jar
	insinto /usr/share/${PN}
	doins speech.properties
	cp -R ${S}/demo ${D}/usr/share/${PN}
	cp -R ${S}/tools ${D}/usr/share/${PN}
	dodoc README.txt RELEASE_NOTES acknowledgments.txt
	use doc && cp -R ${S}/docs ${D}/usr/share/doc/${P} && cp -R ${S}/javadoc ${D}/usr/share/doc/${P}/api
}
