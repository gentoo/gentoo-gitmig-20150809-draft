# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/wml/wml-2.0.11-r3.ebuild,v 1.6 2008/04/20 11:25:50 vapier Exp $

inherit fixheadtails eutils autotools multilib

DESCRIPTION="Website META Language"
HOMEPAGE="http://thewml.org/"
SRC_URI="http://thewml.org/distrib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ~s390 sparc x86"
IUSE=""

RDEPEND="dev-libs/libpcre
	sys-devel/libtool
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	ht_fix_all
	cd "${S}"

	epatch "${FILESDIR}/wml-2.0.9-gcc41.patch"
	epatch "${FILESDIR}/wml-2.0.9-autotools-update.patch"
	epatch "${FILESDIR}/wml-2.0.11-tmpfile.patch"
	epatch "${FILESDIR}"/${P}-autotools.patch

	einfo "Patching Makefile.in files to fix various problems"
	# Patch Makefile to avoid stripping binaries
	for m in $(find "${S}" -name Makefile.in -print); do
		sed -i -e "s/-m 755 -s/-m 755/" "${m}" || die "Could not run sed on ${m}"
		sed -i -e "/^libdir.*/s::libdir = \$(prefix)/$(get_libdir)\$(libsubdir):" "${m}" || die "Could not run sed on ${m}"
	done

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
	econf --without-included-ltdl || die "./configure failed"
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
