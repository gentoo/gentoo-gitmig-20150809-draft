# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/freetts/freetts-1.2.ebuild,v 1.7 2005/07/21 19:50:38 eradicator Exp $

inherit java-pkg eutils

DESCRIPTION="A speech synthesis system written entirely in Java"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://freetts.sourceforge.net/"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.6.0
	app-arch/sharutils
	app-arch/unzip
	mbrola? ( app-accessibility/mbrola )
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

LICENSE="sun-bcla-jsapi freetts"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc jikes mbrola"

#S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	chmod 0755 jsapi.sh
	epatch ${FILESDIR}/jsapi-gentoo.diff

	use mbrola && echo "mbrola.base=/usr/lib/festival/voices/english" \
		>> ${S}/speech.properties
}

src_compile() {
	local antflags="jars"

	cd ${S}/lib
	./jsapi.sh && cd ${S}
	use doc && unzip -qq javadoc.zip
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
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
	use doc && cp -R ${S}/docs ${D}/usr/share/doc/${P} && \
		cp -R ${S}/javadoc ${D}/usr/share/doc/${P}/api
}
