# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jffi/jffi-0.3-r3.ebuild,v 1.1 2009/06/03 19:58:15 caster Exp $

# Probably best to leave the CFLAGS as they are here. See...
# http://weblogs.java.net/blog/kellyohair/archive/2006/01/compilation_of_1.html

EAPI="2"
JAVA_PKG_IUSE="source test"
inherit java-pkg-2 java-ant-2 toolchain-funcs flag-o-matic

DESCRIPTION="An optimized Java interface to libffi"
HOMEPAGE="http://kenai.com/projects/jffi"
SRC_URI="mirror://gentoo//${P}.tar.bz2"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	virtual/libffi"

DEPEND=">=virtual/jdk-1.5
	virtual/libffi
	test? ( dev-java/ant-junit4 )"

JAVA_PKG_BSFIX_NAME="build-impl.xml"

java_prepare() {
	# Delete the bundled JARs.
	find lib -name "*.jar" -delete || die
	# Delete the bundled libffi
	rm -rf jni/libffi || die

	# bug #271533 and #272058
	epatch "${FILESDIR}/${PV}-makefile-flags.patch"

	# bug #272058
	append-cflags $(pkg-config --cflags-only-I libffi)

	# any better function for this, excluding get_system_arch in java-vm-2 which is incorrect to inherit ?
	local arch="${ARCH}"
	use x86 && arch="i386"

	# Fetch our own prebuilt libffi.
	mkdir -p "build/jni/libffi-${arch}-linux/.libs" || die

	ln -snf "/usr/$(get_libdir)/libffi.so" \
		"build/jni/libffi-${arch}-linux/.libs/libffi_convenience.a" || die

	# Don't include prebuilt files for other archs.
	sed -i '/<zipfileset src="archive\//d' custom-build.xml || die
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use source && java-pkg_dosrc src/*
}

src_test() {
	ANT_TASKS="ant-junit4" eant test \
		-Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)"
}
