# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/freetts/freetts-1.2.1.ebuild,v 1.1 2005/07/26 07:50:25 eradicator Exp $

inherit java-pkg eutils

DESCRIPTION="A speech synthesis system written entirely in Java"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://freetts.sourceforge.net/"

RDEPEND=">=virtual/jre-1.4
	mbrola? ( >=app-accessibility/mbrola-3.0.1h-r3 )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/sharutils
	>=dev-java/ant-core-1.6.0
	app-arch/unzip
	jikes? ( dev-java/jikes )"

LICENSE="sun-bcla-jsapi freetts"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc jikes mbrola"

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	chmod 0755 jsapi.sh
	epatch ${FILESDIR}/jsapi-gentoo.diff

	use mbrola && echo "mbrola.base=/opt/mbrola/" >> ${S}/speech.properties
}

src_compile() {
	local antflags="jars"

	cd ${S}/lib
	./jsapi.sh && cd ${S}
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar lib/*.jar mbrola/*.jar

	echo "#!/bin/bash" > ${PN}
	if use mbrola; then
		echo "java -Dmbrola.base=/opt/mbrola/ -jar /usr/share/freetts/lib/freetts.jar \${@}" >> ${PN}
	else
		echo "java -jar /usr/share/freetts/lib/freetts.jar \${@}" >> ${PN}
	fi

	dobin ${PN}

	insinto /usr/share/${PN}
	doins speech.properties

	cp -R ${S}/demo ${D}/usr/share/${PN}
	cp -R ${S}/tools ${D}/usr/share/${PN}

	dodoc README.txt RELEASE_NOTES acknowledgments.txt
	use doc && cp -R ${S}/docs ${D}/usr/share/doc/${P} && cp -R ${S}/javadoc ${D}/usr/share/doc/${P}/api
}
