# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/freetts/freetts-1.2_beta.ebuild,v 1.10 2004/10/19 20:37:24 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="FreeTTS is a speech synthesis system written entirely in the Java programming language"
SRC_URI="mirror://sourceforge/freetts/${PN}-srcs-${PV/./_}.zip"
HOMEPAGE="http://freetts.sourceforge.net"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.6.0
	app-arch/unzip
	mbrola? ( app-accessibility/mbrola )
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="sun-bcla-jsapi freetts"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes mbrola"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	chmod 755 jsapi.sh
	epatch ${FILESDIR}/jsapi-gentoo.diff

	use mbrola && echo "mbrola.base=/usr/lib/festival/voices/english" >> ${S}/speech.properties
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
	dodir ${JDK_HOME}/jre/lib
	dosym \
		/usr/share/${PN}/speech.properties \
		${JDK_HOME}/jre/lib/speech.properties
	dodoc README.txt RELEASE_NOTES acknowledgments.txt
	use doc && cp -R ${S}/docs ${D}/usr/share/doc/${P} && cp -R ${S}/javadoc ${D}/usr/share/doc/${P}/api
}
