# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libid3tag/libid3tag-0.15.0b.ebuild,v 1.18 2005/01/12 03:57:18 vapier Exp $

DESCRIPTION="The MAD id3tag library"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE="debug"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.3"

src_compile() {
	econf $(use_enable debug debugging) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc CHANGES CREDITS README TODO VERSION

	# This file must be updated with every version update
	dodir /usr/lib/pkgconfig
	insinto /usr/lib/pkgconfig
	doins ${FILESDIR}/id3tag.pc
}
