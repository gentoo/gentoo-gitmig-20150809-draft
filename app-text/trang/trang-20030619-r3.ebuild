# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/trang/trang-20030619-r3.ebuild,v 1.3 2007/01/02 04:58:19 ticho Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Trang: Multi-format schema converter based on RELAX NG"
HOMEPAGE="http://thaiopensource.com/relaxng/trang.html"
SRC_URI="http://www.thaiopensource.com/download/${P}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc source"

COMMON_DEP="
	=dev-java/xerces-1.3*
	>=dev-java/xerces-2.7.1"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

# javadoc does not build correctly with 1.6
# Can't use doc? ( ) !doc? ( ) either
# http://bugs.gentoo.org/show_bug.cgi?id=156228
# so forcing 1.4 || 1.5

DEPEND="
	|| ( =virtual/jdk-1.4* =virtual/jdk-1.5* )
	${COMMON_DEP}
	dev-java/ant-core
	app-arch/unzip"

src_unpack() {
	unpack ${A}

	cd "${S}"
	#rm -v *.jar
	cp ${FILESDIR}/build-r1.xml "${S}/build.xml"

	mkdir -p "${S}/src/"
	cd "${S}/src"
	unpack ./../src.zip
}

src_compile() {
	eant jar $(use_doc) -Dproject.name=${PN} -Dpackage.name=${PN} \
		-Dclasspath="$(java-pkg_getjars xerces-2,xerces-1.3)" \
		-Dpkg="*"
}

src_install() {
	java-pkg_dojar dist/*.jar
	java-pkg_dolauncher trang \
		--main com.thaiopensource.relaxng.translate.Driver
	java-pkg_dohtml *.html

	use doc && java-pkg_dojavadoc dist/doc
	use source && java-pkg_dosrc src/{org,com}
}
