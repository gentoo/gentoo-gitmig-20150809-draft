# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian-bindings/xapian-bindings-1.0.12.ebuild,v 1.1 2009/05/01 19:34:40 gengor Exp $

EAPI=2

inherit mono java-pkg-opt-2

DESCRIPTION="SWIG and JNI bindings for Xapian"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://www.oligarchy.co.uk/xapian/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="python php tcl mono java ruby"

COMMONDEPEND="=dev-libs/xapian-${PV}
	python? ( >=dev-lang/python-2.2[threads] )
	php? ( >=dev-lang/php-4 )
	tcl? ( >=dev-lang/tcl-8.1 )
	mono? ( >=dev-lang/mono-1.0.8 )
	ruby? ( dev-lang/ruby )"

DEPEND="${COMMONDEPEND}
	python? ( >=dev-lang/swig-1.3.29-r1 )
	java? ( >=virtual/jdk-1.3 )"

RDEPEND="${COMMONDEPEND}
	java? ( >=virtual/jre-1.3 )"

src_compile() {
	if use java; then
		CXXFLAGS="${CXXFLAGS} $(java-pkg_get-jni-cflags)"
	fi
	econf \
		$(use_with python) \
		$(use_with php) \
		$(use_with tcl) \
		$(use_with mono csharp) \
		$(use_with java) \
		$(use_with ruby) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die

	if use java; then
		java-pkg_dojar java/built/xapian_jni.jar
		# TODO: make the build system not install this...
		java-pkg_doso "${D}/${S}/java/built/libxapian_jni.so"
		rm "${D}/${S}/java/built/libxapian_jni.so"
		rmdir -p "${D}/${S}/java/built"
		rmdir -p "${D}/${S}/java/native"
	fi

	# For some USE combos this directory is not created
	if [[ -d "${D}/usr/share/doc/xapian-bindings" ]]; then
		mv "${D}/usr/share/doc/xapian-bindings" "${D}/usr/share/doc/${PF}"
	fi

	dodoc AUTHORS HACKING NEWS TODO README || die "dodoc failed"
}
