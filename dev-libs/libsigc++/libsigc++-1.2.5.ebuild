# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.5.ebuild,v 1.22 2006/07/06 01:01:42 vapier Exp $

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc-macos ppc64 sh sparc x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	amd64? ( >=sys-devel/automake-1.7 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	libtoolize -c -f --automake
	WANT_AUTOMAKE=1.7 aclocal -I scripts ${ACLOCAL_FLAGS} || die "aclocal failed.  Are your \$ACLOCAL_FLAGS sane?"
	WANT_AUTOMAKE=1.7 automake --add-missing --copy || die
	WANT_AUTOCONF=2.5 autoconf || die
}

src_compile() {
	local myconf

	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	econf ${myconf} --enable-maintainer-mode --enable-threads || die

	emake || die "emake failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FEATURES IDEAS README INSTALL NEWS TODO
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0 and sig++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
