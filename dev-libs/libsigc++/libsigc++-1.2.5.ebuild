# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.5.ebuild,v 1.26 2008/12/08 00:23:44 darkside Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.7"

inherit autotools

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.2"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="debug"

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	AT_M4DIR="scripts" eautoreconf
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
	ewarn "To allow parallel installation of sigc++-1.0 and sigc++-1.2,"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsigc++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
