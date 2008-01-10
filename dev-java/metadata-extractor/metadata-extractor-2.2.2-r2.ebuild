# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/metadata-extractor/metadata-extractor-2.2.2-r2.ebuild,v 1.3 2008/01/10 23:10:39 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A general metadata extraction framework. Support currently exists for Exif and Iptc metadata segments. Extraction of these segments is provided for Jpeg files"
HOMEPAGE="http://www.drewnoakes.com/code/exif/"
SRC_URI="http://www.drewnoakes.com/code/exif/metadata-extractor-${PV}-src.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="test"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	=dev-java/junit-3.8*"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}/

src_unpack() {
	jar xf "${DISTDIR}/${A}"
	sed -e "s:clean, compile, test:clean, compile:" -i metadata-extractor.build || die "sed failed"
	mv metadata-extractor.build build.xml

	java-pkg_jar-from --build-only --into lib/ junit junit.jar
}

src_compile() {
	eant dist-binaries
}

src_install() {
	dodoc ReleaseNotes.txt
	java-pkg_newjar dist/*.jar "${PN}.jar"
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}
