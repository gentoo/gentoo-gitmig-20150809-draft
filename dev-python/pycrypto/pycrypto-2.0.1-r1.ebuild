# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-2.0.1-r1.ebuild,v 1.4 2006/02/01 04:48:45 vapier Exp $

inherit eutils distutils toolchain-funcs flag-o-matic

DESCRIPTION="Python Cryptography Toolkit"
HOMEPAGE="http://www.amk.ca/python/code/crypto.html"
SRC_URI="http://www.amk.ca/files/python/crypto/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~ppc ~ppc-macos ~s390 ~sh ~sparc ~x86"
IUSE="bindist test"

RDEPEND="virtual/python"
DEPEND="${RDEPEND}
	test? ( =dev-python/sancho-0.11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use bindist && epatch "${FILESDIR}"/${P}-bindist.patch
}

src_compile() {
	# sha256 hashes occasionally trigger ssp when built with
	# -finline-functions (implied by -O3).
	gcc-specs-ssp && append-flags -fno-inline-functions
	distutils_src_compile
}

src_test() {
	python ./test.py || die "test failed"
	if use test ; then
		local x
		cd test
		for x in test_*.py ; do
			python ${x} || die "${x} failed"
		done
	fi
}

DOCS="ACKS ChangeLog PKG-INFO README TODO Doc/pycrypt.tex"
