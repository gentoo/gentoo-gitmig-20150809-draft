# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-2.0.5.ebuild,v 1.10 2005/03/28 15:52:45 gmsoft Exp $

inherit eutils

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"
SRC_URI="mirror://sourceforge/libsigc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.3"
KEYWORDS="x86 ppc alpha amd64 sparc ppc64 hppa"
IUSE="debug"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc-3.4.patch
}
src_compile() {
	local myconf
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	# added libtoolize, add "-I scripts" to aclocal, autoconf before econf
	# all these changes are necessary on amd64
	# Danny van Dyk (kugelfang@gentoo.org)
	if use amd64; then
		libtoolize -c -f --automake
		aclocal -I scripts
		automake --gnu --add-missing
		autoconf
	fi
	econf ${myconf} || die
	emake || die "emake failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING* README INSTALL NEWS TODO
}

pkg_postinst() {
	ewarn "To allow parallel installation of sig++-1.0, sig++-1.2, and sig++2.0"
	ewarn "the header files are now installed in a version specific"
	ewarn "subdirectory.  Be sure to unmerge any libsig++ versions"
	ewarn "< 1.0.4 that you may have previously installed."
}
