# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.10.ebuild,v 1.2 2004/04/26 03:08:53 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="Library of cd audio related routines."
HOMEPAGE="http://libcdaudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"

src_compile() {
	# -fPIC is required for this library on alpha, see bug #17192
	use alpha && append-flags -fPIC

	econf --enable-threads --with-gnu-ld || die "econf failed"
	emake || die "compile problem."
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangLog INSTALL NEWS README TODO
}
