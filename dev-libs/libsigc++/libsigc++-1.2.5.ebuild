# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.5.ebuild,v 1.8 2004/01/14 18:26:56 agriffis Exp $

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.2"
KEYWORDS="x86 ~ppc ~sparc hppa ~amd64 ~alpha"
IUSE="debug"

DEPEND="virtual/glibc"

src_compile() {
	local myconf
	[ "${ARCH}" = "amd64" ] && libtoolize -c -f
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	econf ${myconf} --enable-threads || die
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
