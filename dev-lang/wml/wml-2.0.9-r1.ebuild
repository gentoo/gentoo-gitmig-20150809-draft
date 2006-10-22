# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.9-r1.ebuild,v 1.10 2006/10/22 21:33:03 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit fixheadtails eutils autotools multilib

DESCRIPTION="Website META Language"
HOMEPAGE="http://www.engelschall.com/sw/wml/"
SRC_URI="http://www.engelschall.com/sw/wml/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc s390 sparc x86"
IUSE=""

RDEPEND="dev-libs/libpcre
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	ht_fix_all
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-autotools-update.patch"

	for d in $(find "${S}" \( -name configure.ac -o -name configure.in \) -exec dirname {} \;); do
		pushd ${d} &>/dev/null
		AT_NOELIBTOOLIZE="yes" eautoreconf
		popd &>/dev/null
	done

	elibtoolize
}

src_compile() {
	econf --libdir=/usr/$(get_libdir)/wml || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
