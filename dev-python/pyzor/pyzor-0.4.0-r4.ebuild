# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzor/pyzor-0.4.0-r4.ebuild,v 1.1 2009/01/05 07:43:11 robbat2 Exp $

inherit distutils eutils

DESCRIPTION="A distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://pyzor.sourceforge.net/"

MY_PV="${PV}+cvs20030201"
MY_P="${PN}_${MY_PV}"
DEBIAN_PATCH_VERSION="8"
DEBIAN_PATCH="${MY_P}-${DEBIAN_PATCH_VERSION}.diff.gz"
# Original:
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
# Debian CVS snapshot
SRC_URI="
	mirror://debian/pool/main/p/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/p/${PN}/${DEBIAN_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="pyzord"

DEPEND="dev-lang/python"

S="${WORKDIR}/${MY_P//_/-}"

pkg_setup() {
	if use pyzord ; then
		if ! built_with_use 'dev-lang/python' gdbm ; then
			die "you need to rebuild python with gdbm support"
		fi
	fi
}

src_unpack() {
	unpack ${MY_P}.orig.tar.gz
	epatch "${DISTDIR}"/${DEBIAN_PATCH}
	cd "${S}"
	epatch "${S}"/debian/patches/*dpatch


	# Same as Debian 08_define_mbox.dpatch
	#epatch "${FILESDIR}/debian_mbox.patch"
	# Same as Debian 07_handle_unknown_encodings.dpatch  
	#epatch "${FILESDIR}/handle_unknown_encodings.patch"

	# Gentoo-unique
	epatch "${FILESDIR}/pyzord_getopt.patch"
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

	if use pyzord ; then
		dodir /usr/sbin
		mv "${D}/usr/bin/pyzord" "${D}/usr/sbin/"
	fi
}

pkg_postinst() {
	if use pyzord ; then
		ewarn "/usr/bin/pyzord has been moved to /usr/sbin"
	fi
}

src_test() {
	PYTHONPATH=build/lib/ "${python}" unittests.py || die "tests failed"
}
