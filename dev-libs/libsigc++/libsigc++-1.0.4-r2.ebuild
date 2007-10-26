# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.0.4-r2.ebuild,v 1.22 2007/10/26 13:29:25 dang Exp $

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sh sparc x86"
IUSE="debug"

DEPEND=""

src_compile() {
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf ${myconf} || die

	# Fix sandbox violation when old libsigc++ is already installed,
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
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README* INSTALL NEWS
}

pkg_postinst() {
	ewarn "To allow parallel installation of sigc++-1.0 and sigc++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsigc++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
