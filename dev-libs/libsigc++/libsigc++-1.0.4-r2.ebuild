# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.0.4-r2.ebuild,v 1.16 2004/01/29 04:28:11 agriffis Exp $

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="debug"

DEPEND="virtual/glibc"

src_compile() {
	local myconf=""
	if [ "$ARCH" = "amd64" ]
	then
		libtoolize -c -f
	fi

	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf ${myconf} || die

	# Fix sandbox violation when old libsig++ is already installed,
	# hopefully this will go away after the header location settles down
	# Comment out the remove old header directory line

	cp sigc++/Makefile sigc++/Makefile.orig
	sed -e 's:\(@if\):#\1:' \
		sigc++/Makefile.orig > sigc++/Makefile

	# This occurs in two places

	cp sigc++/config/Makefile sigc++/config/Makefile.orig
	sed -e 's:\(@if\):#\1:' \
		sigc++/config/Makefile.orig > sigc++/config/Makefile

	emake || die
}

src_install() {
	make DESTDIR=${D} \
	     install || die

	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0 and sig++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
