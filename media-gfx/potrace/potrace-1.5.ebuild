# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potrace/potrace-1.5.ebuild,v 1.4 2005/02/18 20:18:08 agriffis Exp $

DESCRIPTION="Transforming bitmaps into vector graphics"
HOMEPAGE="http://potrace.sourceforge.net/"
SRC_URI="http://potrace.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64 alpha ia64"

IUSE="zlib"

DEPEND="zlib? ( sys-libs/zlib )"

src_compile() {
	econf $(use_enable zlib) --enable-a4 || die "econf failed."
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."

	dodoc AUTHORS NEWS README
}
