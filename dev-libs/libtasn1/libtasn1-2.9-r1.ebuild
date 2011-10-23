# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-2.9-r1.ebuild,v 1.10 2011/10/23 11:22:42 scarabeus Exp $

EAPI=4

DESCRIPTION="ASN.1 library"
HOMEPAGE="http://www.gnu.org/software/libtasn1/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="doc static-libs"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"
RDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README THANKS )

src_configure(){
	local myconf

	[[ "${VALGRIND_TESTS}" == "0" ]] && myconf+=" --disable-valgrind-tests"
	econf \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +

	if use doc; then
		dodoc doc/libtasn1.ps || die "dodoc failed"
	fi
}
