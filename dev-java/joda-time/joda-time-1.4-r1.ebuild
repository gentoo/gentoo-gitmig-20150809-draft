# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joda-time/joda-time-1.4-r1.ebuild,v 1.3 2007/08/14 07:44:59 opfer Exp $

JAVA_PKG_IUSE="doc examples source test"
inherit java-pkg-2 java-ant-2

MY_P="${P}-src"

DESCRIPTION="A quality open-source replacement for the Java Date and Time classes."
HOMEPAGE="http://joda-time.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

COMMON_DEP="
	elibc_glibc? ( >=sys-libs/timezone-data-2007c )
"
# test fail compile with 1.5+ because test mock object doesn't override some
# new abstract foo
DEPEND="
	test? (
		=dev-java/junit-3*
		dev-java/ant-junit
		=virtual/jdk-1.4*
	)
	!test? ( >=virtual/jdk-1.4 )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v ${P}.jar || die
}

src_compile() {
	# chokes on static inner class making instance of non-static inner class
	java-pkg_filter-compiler jikes
	# little trick so it doesn't try to download junit
	eant -Djunit.ant=1 -Djunit.present=1 jar $(use_doc)
}

src_test() {
	if has_version "<sys-libs/timezone-data-2007c"; then
		ewarn "Tests are known to fail with older versions of"
		ewarn "sys-libs/timezone-data. Please update to the latest stable"
		ewarn "version. We don't force it because not all libc"
		ewarn "implementations use that package. See bugzilla for details:"
		ewarn "https://bugs.gentoo.org/show_bug.cgi?id=170189"
	fi

	ANT_TASKS="ant-junit" eant -Djunit.jar="$(java-pkg_getjars junit)" test
}

src_install() {
	java-pkg_newjar build/${P}.jar

	dodoc LICENSE.txt NOTICE.txt RELEASE-NOTES.txt ToDo.txt || die
	use doc && java-pkg_dojavadoc build/docs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/java/org
}
