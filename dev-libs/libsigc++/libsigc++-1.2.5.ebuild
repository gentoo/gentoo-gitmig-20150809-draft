# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.5.ebuild,v 1.18 2005/01/09 14:56:42 corsair Exp $

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.2"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="debug"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	amd64? ( >=sys-devel/automake-1.7 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use amd64; then
		libtoolize -c -f --automake
		WANT_AUTOMAKE=1.7 aclocal -I scripts ${ACLOCAL_FLAGS} || die "aclocal failed.  Are your \$ACLOCAL_FLAGS sane?"
		WANT_AUTOMAKE=1.7 automake --add-missing --copy
		WANT_AUTOCONF=2.5 autoconf
	fi
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
	dodoc AUTHORS ChangeLog FEATURES IDEAS COPYING* \
		README INSTALL NEWS TODO
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0 and sig++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
