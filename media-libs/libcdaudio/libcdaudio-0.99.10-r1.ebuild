# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.10-r1.ebuild,v 1.1 2005/04/05 02:28:10 obz Exp $

inherit flag-o-matic

DESCRIPTION="Library of cd audio related routines."
HOMEPAGE="http://libcdaudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"
IUSE=""

src_unpack() {
	unpack ${A}
	# CAN-2005-0706 (#84936)
	epatch ${FILESDIR}/${PN}-0.99-CAN-2005-0706.patch
}

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
