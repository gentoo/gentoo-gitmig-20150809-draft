# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.11-r1.ebuild,v 1.6 2007/06/24 23:10:56 vapier Exp $

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

DEPEND="dev-libs/libpcre
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	ht_fix_all
	cd "${S}"

	epatch "${FILESDIR}/wml-2.0.9-gcc41.patch"
	epatch "${FILESDIR}/wml-2.0.9-autotools-update.patch"

	# Patch Makefile to avoid stripping binaries
	sed -i -e "s/-m 755 -s/-m 755/" Makefile.in || die
	sed -i -e "s/-m 755 -s/-m 755/" wml_backend/p3_eperl/Makefile.in || die

	# Patch Makefile to avoid a dependency on lynx just for documentation
	sed -i -e "s/lynx -dump -nolist -width=72/cat/" wml_aux/tidy/Makefile.in || die

	for d in $(find "${S}" \( -name configure.ac -o -name configure.in \) -exec dirname {} \;); do
		pushd ${d} &>/dev/null
		AT_NOELIBTOOLIZE="yes" eautoreconf
		popd &>/dev/null
	done

	elibtoolize
}

src_compile() {
	econf --libdir=/usr/$(get_libdir) || die "./configure failed"
	emake || die "emake failed"
}

# The default src_test first checks if 'make test' is possible using the '-n'
# option of make, but this messes up the tests completely.
src_test() {
	emake -j1 test
}

src_install() {
	einstall || die
	dodoc ANNOUNCE BUGREPORT C* INSTALL MANIFEST README* SUPPORT VERSION*
}
