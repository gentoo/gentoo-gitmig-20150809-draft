# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvn/pysvn-1.7.2.ebuild,v 1.4 2010/06/22 18:38:00 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit eutils multilib python toolchain-funcs

DESCRIPTION="Object-oriented python bindings for subversion"
HOMEPAGE="http://pysvn.tigris.org/"
SRC_URI="http://pysvn.barrys-emacs.org/source_kits/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-freebsd ~ppc-macos"
IUSE="doc examples"

DEPEND="dev-lang/python
	dev-vcs/subversion
	>=dev-python/pycxx-6.1.0"
RDEPEND="${DEPEND}"

src_prepare() {
	# Skip test test-06 if executed as root to avoid failure.
	epatch "${FILESDIR}/${PN}-1.7.1-skip_root_test.patch"

	# Don't use internal copy of dev-python/pycxx.
	rm -fr Import

	python_copy_sources

	preparation() {
		cd Source
		if has "${PYTHON_ABI}" 2.4 2.5; then
			"$(PYTHON)" setup.py backport || die "Backport failed"
		fi
	}
	python_execute_function -s preparation
}

src_configure() {
	configuration() {
		cd Source
		"$(PYTHON)" setup.py configure --apr-inc-dir="${EPREFIX}/usr/include/apr-1" --svn-root-dir="${EPREFIX}/usr" || die "Configuration failed with Python {PYTHON_ABI}"

		sed -e 's:^\(CCFLAGS=\)\(.*\):\1$(CFLAGS) \2:g' \
			-e 's:^\(CCCFLAGS=\)\(.*\):\1$(CXXFLAGS) \2:g' \
			-e "/^CCC=/s:g++:$(tc-getCXX):" \
			-e "/^CC=/s:gcc:$(tc-getCC):" \
			-e "/^LDSHARED=/s:g++:$(tc-getCXX):" \
			-i Makefile \
			|| die "sed failed in Makefile"
	}
	python_execute_function -s configuration
}

src_compile() {
	building() {
		cd Source
		emake
	}
	python_execute_function -s building
}

src_test() {
	testing() {
		cd Source
		emake test || die "test-pysvn.so failed with Python ${PYTHON_ABI}"
		emake -C ../Tests || die "Tests failed with Python ${PYTHON_ABI}"
	}
	python_execute_function -s testing
}

src_install() {
	installation() {
		cd Source/pysvn
		exeinto "$(python_get_sitedir)/pysvn"
		doexe _pysvn*$(get_modname) || die "doexe failed"
		insinto "$(python_get_sitedir)/pysvn"
		doins __init__.py || die "doins failed"
	}
	python_execute_function -s installation

	if use doc; then
		dohtml -r Docs/ || die "dohtml failed"
	fi

	if use examples; then
		docinto examples
		dodoc Examples/Client/* || die "dodoc examples failed"
	fi
}

pkg_postinst() {
	python_mod_optimize pysvn
}

pkg_postrm() {
	python_mod_cleanup pysvn
}
