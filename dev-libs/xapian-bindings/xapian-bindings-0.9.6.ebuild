# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian-bindings/xapian-bindings-0.9.6.ebuild,v 1.1 2006/05/25 01:33:58 marienz Exp $

inherit mono eutils autotools java-pkg

DESCRIPTION="SWIG and JNI bindings for Xapian"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="python php tcltk mono java ruby"

COMMONDEPEND="=dev-libs/xapian-${PV}
	python? ( >=dev-lang/python-2.1 )
	php? ( >=dev-lang/php-4 )
	tcltk? ( >=dev-lang/tcl-8.1 )
	mono? ( >=dev-lang/mono-1.0.8 )
	ruby? ( dev-lang/ruby )"

DEPEND="${COMMONDEPEND}
	java? ( >=virtual/jdk-1.3 )"

RDEPEND="${COMMONDEPEND}
	java? ( >=virtual/jre-1.3 )"


src_unpack() {
	unpack ${A}
	cd "${S}"

	# applied upstream
	epatch "${FILESDIR}/${P}-parallel-make.patch"
	cd java
	# from upstream
	epatch "${FILESDIR}/${P}-java-array-delete.patch"
	cd ../php
	# from upstream
	epatch "${FILESDIR}/${P}-php-tests.patch"
	# submitted upstream
	epatch "${FILESDIR}/${P}-php-tests-2.patch"
	cd ..

	eautoreconf
}

src_compile() {
	if use java; then
		CXXFLAGS="${CXXFLAGS} -I${JAVA_HOME}/include"
		CXXFLAGS="${CXXFLAGS} -I${JAVA_HOME}/include/linux"
	fi
	econf \
		$(use_with python) \
		$(use_with php) \
		$(use_with tcltk tcl) \
		$(use_with mono csharp) \
		$(use_with java) \
		$(use_with ruby) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die

	if use java; then
		java-pkg_dojar java/built/xapian_jni.jar
		# TODO: make the build system not install this...
		java-pkg_doso "${D}/${S}/java/built/libxapian_jni.so"
		rm "${D}/${S}/java/built/libxapian_jni.so"
		rmdir -p "${D}/${S}/java/built"
	fi

	# For some USE combos this directory is not created
	if [[ -d "${D}/usr/share/doc/xapian-bindings" ]]; then
		mv "${D}/usr/share/doc/xapian-bindings" "${D}/usr/share/doc/${PF}"
	fi

	dodoc AUTHORS HACKING NEWS TODO README
}
