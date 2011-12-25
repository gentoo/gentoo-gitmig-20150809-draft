# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jna/jna-3.4.0.ebuild,v 1.1 2011/12/25 14:23:57 fordfrog Exp $

EAPI="4"

JAVA_PKG_IUSE="test doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2 toolchain-funcs flag-o-matic

DESCRIPTION="Java Native Access (JNA)"
HOMEPAGE="https://github.com/twall/jna#readme"
SRC_URI="https://github.com/twall/jna/tarball/3.4.0 -> ${P}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+awt +nio-buffers"
S="${WORKDIR}/twall-jna-3e5b84f"

RDEPEND="virtual/libffi
	>=virtual/jre-1.6"

DEPEND="virtual/libffi
	>=virtual/jdk-1.6
	test? (
		dev-java/junit:0
		dev-java/ant-junit:0
		dev-java/ant-trax:0
	)"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="jar contrib-jars"

java_prepare() {
	# delete bundled jars
	find -name "*.jar" | xargs rm -v

	# respect CFLAGS, don't inhibit warnings, honour CC
	# fix build.xml file
	epatch "${FILESDIR}/${PV}-makefile-flags.patch" "${FILESDIR}/${PV}-build.xml.patch"

	# Fetch our own prebuilt libffi.
	mkdir -p build/native/libffi/.libs || die
	ln -snf "/usr/$(get_libdir)/libffi.so" \
		build/native/libffi/.libs/libffi_convenience.a || die

	# Build to same directory on 64-bit archs.
	ln -snf build build-d64 || die

	if ! use awt ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_JAWT/g" "${S}"/native/Makefile || die
	fi

	if ! use nio-buffers ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_NIO_BUFFERS/g" "${S}"/native/Makefile || die
	fi
}

EANT_EXTRA_ARGS="-Ddynlink.native=true"

src_install() {
	java-pkg_dojar build/${PN}.jar
	java-pkg_dojar contrib/platform/dist/platform.jar
	java-pkg_doso build/native/libjnidispatch.so
	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadoc doc/javadoc
}

src_test() {
	unset DISPLAY

	mkdir -p lib
	java-pkg_jar-from --into lib --build-only junit

	ANT_TASKS="ant-junit ant-nodeps ant-trax" \
		ANT_OPTS="-Djava.awt.headless=true" eant \
		${EANT_EXTRA_ARGS} test
}
