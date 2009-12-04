# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-2.1.0_beta1.ebuild,v 1.2 2009/12/04 23:24:44 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils flag-o-matic

MY_PV="${PV/_beta/b}"

DESCRIPTION="Python Cryptography Toolkit"
HOMEPAGE="http://www.dlitz.net/software/pycrypto/"
SRC_URI="http://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/${PN}-${MY_PV}.tar.gz"

LICENSE="public-domain PSF-2.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc +gmp"

RDEPEND="gmp? ( dev-libs/gmp )"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils dev-python/epydoc )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS="ACKS ChangeLog README TODO"

pkg_setup() {
	# Some tests fail with some limit of inlining of functions.
	append-flags -fno-inline-functions
}

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-2.1.0-gmp.patch"
}

src_configure() {
	use gmp \
		&& export USE_GMP="1" \
		|| export USE_GMP="0"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		rst2html.py Doc/pycrypt.rst > Doc/index.html

		# Build documentation only once.
		documentation_built="0"
		generate_documentation() {
			[[ "${documentation_built}" == "1" ]] && return
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" epydoc --config=Doc/epydoc-config --exclude-introspect="^Crypto\.(Random\.OSRNG\.nt|Util\.winrandom)$" || die "Generation of documentation failed"
			documentation_built="1"
		}
		python_execute_function -q generate_documentation
		unset documentation_built
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml Doc/index.html || die "dohtml failed"
		dohtml Doc/apidoc/* || die "dohtml failed"
	fi
}
