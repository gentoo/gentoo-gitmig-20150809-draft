# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian-bindings/xapian-bindings-1.0.17.ebuild,v 1.1 2009/11/22 16:52:35 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit java-pkg-opt-2 mono python

DESCRIPTION="SWIG and JNI bindings for Xapian"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="java mono php python ruby tcl"

COMMONDEPEND="=dev-libs/xapian-${PV}
	mono? ( >=dev-lang/mono-1.0.8 )
	php? ( >=dev-lang/php-4 )
	python? ( >=dev-lang/python-2.2[threads] )
	ruby? ( dev-lang/ruby )
	tcl? ( >=dev-lang/tcl-8.1 )"
DEPEND="${COMMONDEPEND}
	python? ( >=dev-lang/swig-1.3.29-r1 )
	java? ( >=virtual/jdk-1.3 )"
RDEPEND="${COMMONDEPEND}
	java? ( >=virtual/jre-1.3 )"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	sed \
		-e 's:\(^pylib_DATA = xapian.py\).*:\1:' \
		-e 's|\(^xapian.py: modern/xapian.py\)|\1 _xapian$(PYTHON_SO)|' \
		-i python/Makefile.{am,in} || die "sed failed"
}

src_configure() {
	if use java; then
		CXXFLAGS="${CXXFLAGS} $(java-pkg_get-jni-cflags)"
	fi
	econf \
		$(use_with java) \
		$(use_with mono csharp) \
		$(use_with php) \
		$(use_with python) \
		$(use_with ruby) \
		$(use_with tcl)

	# Python bindings are built/tested/installed manually.
	sed -e "/SUBDIRS =/s/ python//" -i Makefile || die "sed Makefile"
}

src_compile() {
	default

	if use python; then
		python_copy_sources python
		building() {
			emake PYTHON="$(PYTHON)" PYTHON_INC="$(python_get_includedir)" PYTHON_LIB="$(python_get_libdir)" pylibdir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_test() {
	default

	if use python; then
		testing() {
			emake PYTHON="$(PYTHON)" PYTHON_INC="$(python_get_includedir)" PYTHON_LIB="$(python_get_libdir)" pylibdir="$(python_get_sitedir)" check
		}
		python_execute_function -s --source-dir python testing
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use java; then
		java-pkg_dojar java/built/xapian_jni.jar
		# TODO: make the build system not install this...
		java-pkg_doso "${D}/${S}/java/built/libxapian_jni.so"
		rm "${D}/${S}/java/built/libxapian_jni.so"
		rmdir -p "${D}/${S}/java/built"
		rmdir -p "${D}/${S}/java/native"
	fi

	if use python; then
		installation() {
			emake DESTDIR="${D}" PYTHON="$(PYTHON)" PYTHON_INC="$(python_get_includedir)" PYTHON_LIB="$(python_get_libdir)" pylibdir="$(python_get_sitedir)" install
		}
		python_execute_function -s --source-dir python installation
	fi

	# For some USE combos this directory is not created
	if [[ -d "${D}/usr/share/doc/xapian-bindings" ]]; then
		mv "${D}/usr/share/doc/xapian-bindings" "${D}/usr/share/doc/${PF}"
	fi

	dodoc AUTHORS HACKING NEWS TODO README || die "dodoc failed"
}

pkg_postinst() {
	if use python; then
		python_mod_optimize xapian.py
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup xapian.py
	fi
}
