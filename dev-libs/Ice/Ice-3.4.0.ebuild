# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/Ice/Ice-3.4.0.ebuild,v 1.3 2011/11/13 20:27:38 vapier Exp $

EAPI="2"

PYTHON_DEPEND="python? 2"
RESTRICT_PYTHON_ABIS="3.*"
RUBY_OPTIONAL="yes"
USE_RUBY="ruby18"

inherit eutils toolchain-funcs versionator python mono ruby-ng

DESCRIPTION="ICE middleware C++ library and generator tools"
HOMEPAGE="http://www.zeroc.com/"
SRC_URI="http://www.zeroc.com/download/Ice/$(get_version_component_range 1-2)/${P}.tar.gz
	doc? ( http://www.zeroc.com/download/Ice/$(get_version_component_range 1-2)/${P}.pdf.gz )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples +ncurses mono python ruby test debug"

RDEPEND=">=dev-libs/expat-2.0.1
	>=app-arch/bzip2-1.0.4
	>=dev-libs/openssl-0.9.8o
	|| ( >=sys-libs/db-4.8.30:4.8[cxx] >=sys-libs/db-4.8.30:4.8[-nocxx] )
	=dev-cpp/libmcpp-2.7.2
	ruby? ( $(ruby_implementation_depend ruby18) )
	mono? ( dev-lang/mono )
	!dev-python/IcePy
	!dev-ruby/IceRuby"
DEPEND="${RDEPEND}
	ncurses? ( sys-libs/ncurses sys-libs/readline )
	test? ( >=dev-lang/python-2.4 )"

pkg_setup() {
	use python && python_pkg_setup
}

src_unpack() {
	# prevent ruby-ng.eclass from messing with src_unpack
	default
}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-openssl.patch" \
		"${FILESDIR}/${P}-stream1.patch" \
		"${FILESDIR}/${P}-stream2.patch"

	if tc-is-cross-compiler ; then
		export CROSS_COMPILE=yes
		epatch "${FILESDIR}/${P}-cross-compile.patch"
	fi

	sed -i \
		-e 's|\(install_docdir[[:space:]]*\):=|\1?=|' \
		-e 's|\(install_configdir[[:space:]]*\):=|\1?=|' \
		cpp/config/Make.rules || die "sed failed"

	sed -i \
		-e 's|\(install_pythondir[[:space:]]*\):=|\1?=|' \
		-e 's|\(install_rubydir[[:space:]]*\):=|\1?=|' \
		-e 's|\(install_libdir[[:space:]]*\):=|\1?=|' \
		{py,rb}/config/Make.rules || die "sed failed"

	sed -i \
		-e 's|-O2 ||g' \
		cpp/config/Make.rules.Linux || die "sed failed"

	sed -i \
		-e 's|install-common||' \
		-e 's|demo||' \
		{cpp,cs,php,py,rb}/Makefile || die "sed failed"

	sed -i \
		-e 's|-f -root|-f -gacdir $(GAC_DIR) -root|' \
		cs/config/Make.rules.cs || die "sed failed"

	if ! use test ; then
		sed -i \
			-e 's|^\(SUBDIRS.*\)test|\1|' \
			{cpp,cs,php,py,rb}/Makefile || die "sed failed"
	fi
}

src_configure() {
	MAKE_RULES="prefix=\"${D}/usr\"
		install_docdir=\"${D}/usr/share/doc/${PF}\"
		install_configdir=\"${D}/usr/share/Ice-${PV}/config\"
		embedded_runpath_prefix=\"\"
		LP64=yes"

	use ncurses && OPTIONS="${MAKE_RULES} USE_READLINE=yes" || MAKE_RULES="${MAKE_RULES} USE_READLINE=no"
	use debug && OPTIONS"${MAKE_RULES} OPTIMIZE=no" || MAKE_RULES="${MAKE_RULES} OPTIMIZE=yes"

	MAKE_RULES="${MAKE_RULES} DB_FLAGS=-I/usr/include/db4.8"
	sed -i \
		-e "s|c++|$(tc-getCXX)|" \
		-e "s|\(CFLAGS[[:space:]]*=\)|\1 ${CFLAGS}|" \
		-e "s|\(CXXFLAGS[[:space:]]*=\)|\1 ${CXXFLAGS}|" \
		-e "s|\(LDFLAGS[[:space:]]*=\)|\1 ${LDFLAGS}|" \
		-e "s|\(DB_LIBS[[:space:]]*=\) \-ldb_cxx|\1 -ldb_cxx-4.8|" \
		cpp/config/Make.rules{,.Linux} py/config/Make.rules || die "sed failed"

	if use python ; then
		MAKE_RULES_PY="install_pythondir=\"${D}/$(python_get_sitedir)\"
			install_libdir=\"${D}/$(python_get_sitedir)\""
	fi

	if use ruby ; then
		SITERUBY="$(ruby -r rbconfig -e 'print Config::CONFIG["sitedir"]')"
		MAKE_RULES_RB="install_rubydir=\"${D}/${SITERUBY}\"
			install_libdir=\"${D}/${SITERUBY}\""

		# make it use ruby18 only
		sed -i \
			-e 's|RUBY = ruby|\018|' \
			rb/config/Make.rules || die "sed failed"
	fi

	MAKE_RULES_CS="GACINSTALL=yes GAC_ROOT=\"${D}/usr/$(get_libdir)\" GAC_DIR=/usr/$(get_libdir)"

}

src_compile() {
	if tc-is-cross-compiler ; then
		export CXX="${CHOST}-g++"
	fi

	emake -C cpp ${MAKE_RULES} || die "emake failed"

	if use doc ; then
		emake -C cpp/doc || die "building docs failed"
	fi

	if use python ; then
		emake -C py ${MAKE_RULES} ${MAKE_RULES_PY} || die "emake py failed"
	fi

	if use ruby ; then
		emake -C rb ${MAKE_RULES} ${MAKE_RULES_RB} || die "emake rb failed"
	fi

	if use mono ; then
		emake -C cs ${MAKE_RULES} ${MAKE_RULES_CS} || die "emake cs failed"
	fi
}

src_install() {
	dodoc CHANGES README

	insinto /usr/share/${P}
	doins -r slice

	emake -C cpp ${MAKE_RULES} install || die "emake install failed"

	docinto cpp
	dodoc CHANGES README

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples-cpp
		doins cpp/config/*.cfg
		doins -r cpp/demo/*
	fi

	if use doc ; then
		dohtml -r cpp/doc/reference/*
		dodoc "${WORKDIR}/${P}.pdf"
	fi

	if use python ; then
		dodir $(python_get_sitedir)
		emake -C py ${MAKE_RULES} ${MAKE_RULES_PY} install || die "emake py install failed"

		docinto py
		dodoc py/CHANGES py/README

		if use examples ; then
			insinto /usr/share/doc/${PF}/examples-py
			doins -r py/demo/*
		fi

		cd "${D}/$(python_get_sitedir)"
		PYTHON_MODULES=(*.py)
		PYTHON_MODULES+=(Glacier2 IceBox IceGrid IcePatch2 IceStorm)
		cd "${S}"
	fi

	if use ruby ; then
		dodir "${SITERUBY}"
		emake -C rb ${MAKE_RULES} ${MAKE_RULES_RB} install || die "emake rb install failed"

		docinto rb
		dodoc rb/CHANGES rb/README

		if use examples ; then
			insinto /usr/share/doc/${PF}/examples-rb
			doins -r rb/demo/*
		fi
	fi

	if use mono ; then
		emake -C cs ${MAKE_RULES} ${MAKE_RULES_CS} install || die "emake cs install failed"

		# TODO: anyone has an idea what those are for?
		rm "${D}"/usr/bin/*.xml

		docinto cs
		dodoc cs/CHANGES cs/README

		if use examples ; then
			insinto /usr/share/doc/${PF}/examples-cs
			doins -r cs/demo/*
		fi
	fi
}

src_test() {
	emake -C cpp ${MAKE_RULES} test || die "emake test failed"

	if use python ; then
		emake -C py ${MAKE_RULES} ${MAKE_RULES_PY} test || die "emake py test failed"
	fi

	if use ruby ; then
		emake -C rb ${MAKE_RULES} ${MAKE_RULES_RB} test || die "emake rb test failed"
	fi

	if use mono ; then
		ewarn "Tests for C# are currently disabled."
#		emake -C cs ${MAKE_RULES} ${MAKE_RULES_CS} test || die "emake cs test failed"
	fi
}

pkg_postinst() {
	use python && EAPI="3" python_mod_optimize "${PYTHON_MODULES[@]}"
}

pkg_postrm() {
	use python && EAPI="3" python_mod_cleanup "${PYTHON_MODULES[@]}"
}
