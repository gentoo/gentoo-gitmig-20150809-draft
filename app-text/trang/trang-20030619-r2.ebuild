# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/trang/trang-20030619-r2.ebuild,v 1.2 2006/11/30 15:12:19 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Trang: Multi-format schema converter based on RELAX NG"
HOMEPAGE="http://thaiopensource.com/relaxng/trang.html"
SRC_URI="http://www.thaiopensource.com/download/${P}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=virtual/jre-1.4
	=dev-java/xerces-1.3*
	>=dev-java/xerces-2.7.1"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}

	mkdir -p src/lib
	unzip -d src src.zip || die "failed too unzip"
	cp ${FILESDIR}/build.xml src

	cd src/lib
	java-pkg_jar-from xerces-1.3 xerces.jar
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces.jar
}

src_compile() {
	cd ${S}/src

	eant jar
}

src_install() {
	java-pkg_dojar jar/trang.jar
	java-pkg_dolauncher trang --jar ${PN}.jar
	java-pkg_dohtml *.html
}
