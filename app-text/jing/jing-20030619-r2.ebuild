# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jing/jing-20030619-r2.ebuild,v 1.1 2006/12/03 17:28:49 nichoj Exp $

inherit java-pkg-2 eutils

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://www.thaiopensource.com/download/${P}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
COMMON_DEPEND="
	=dev-java/saxon-8*
	=dev-java/xerces-1.3*
	dev-java/iso-relax
	dev-java/relaxng-datatype"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.3
	${COMMON_DEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd ${S}
	mkdir src/
	unzip -qq -d src/ src.zip || die "failed to unzip"
	cd src/
	epatch ${FILESDIR}/build-patch.diff
	epatch ${FILESDIR}/${P}-xerces.patch

	# remove bundled relaxng-datatype
	rm -r org

	cd ../bin/
	rm -f *.jar
	java-pkg_jar-from iso-relax
	java-pkg_jar-from xerces-1.3 xerces.jar
	java-pkg_jar-from saxon saxon8.jar saxon.jar
	java-pkg_jar-from relaxng-datatype

	cd ..
	cp ${FILESDIR}/build.xml .
	cp ${FILESDIR}/manifest.mf .
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar bin/jing.jar
	java-pkg_dolauncher ${PN} --main com.thaiopensource.relaxng.util.Driver
	use doc && java-pkg_dohtml -r doc/* readme.html
}
