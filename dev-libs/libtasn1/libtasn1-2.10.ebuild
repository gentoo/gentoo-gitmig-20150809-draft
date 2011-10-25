# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtasn1/libtasn1-2.10.ebuild,v 1.1 2011/10/25 23:07:45 radhermit Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="ASN.1 library"
HOMEPAGE="http://www.gnu.org/software/libtasn1/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="doc static-libs"

DEPEND=">=dev-lang/perl-5.6
	sys-devel/bison"

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
	remove_libtool_files

	if use doc ; then
		dodoc doc/libtasn1.pdf
		dohtml doc/reference/html/*
	fi
}
