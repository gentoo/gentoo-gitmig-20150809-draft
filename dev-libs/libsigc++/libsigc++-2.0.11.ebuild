# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-2.0.11.ebuild,v 1.11 2006/07/20 23:13:44 exg Exp $

inherit eutils gnome.org flag-o-matic

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE="debug"

DEPEND="virtual/libc"

src_compile() {
	filter-flags -fno-exceptions
	local myconf
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf ${myconf} || die "econf failed."
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed."
	dodoc AUTHORS ChangeLog  README NEWS TODO
	mv ${D}/usr/share/doc/libsigc-2.0/docs/* ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0, sig++-1.2, and sig++2.0"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
