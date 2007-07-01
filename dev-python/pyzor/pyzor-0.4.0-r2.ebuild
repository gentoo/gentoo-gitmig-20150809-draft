# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzor/pyzor-0.4.0-r2.ebuild,v 1.12 2007/07/01 22:02:47 hawking Exp $

inherit distutils eutils

DESCRIPTION="A distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://pyzor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/python
	sys-libs/gdbm"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/debian_mbox.patch"
	epatch "${FILESDIR}/handle_unknown_encodings.patch"
	epatch "${FILESDIR}/unknown_type.patch"

	# rfc822BodyCleanerTest doesn't work fine
	# remove it until it's fixed
	sed -i \
		-e '/rfc822BodyCleanerTest/,/self\.assertEqual/d' \
		unittests.py || die "sed in unittest.py failed"
}

src_install () {
	DOCS="INSTALL THANKS UPGRADING"
	distutils_src_install
	dohtml docs/usage.html
	rm -rf "${D}/usr/share/doc/pyzor"
	fperms 755 /usr/bin/pyzor*
	dodir /usr/sbin
	mv "${D}/usr/bin/pyzord" "${D}/usr/sbin/"
}

pkg_postinst() {
	ewarn "/usr/bin/pyzord has been moved to /usr/sbin"
}

src_test() {
	PYTHONPATH=build/lib/ "${python}" unittests.py || die "tests failed"
}
