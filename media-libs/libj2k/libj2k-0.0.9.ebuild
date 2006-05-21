# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libj2k/libj2k-0.0.9.ebuild,v 1.1 2006/05/21 20:16:56 genstef Exp $

DESCRIPTION="Lib for Yahoo webcam support in gaim-vv"
HOMEPAGE="http://sourceforge.net/projects/gaim-vv/"
SRC_URI="mirror://sourceforge/gaim-vv/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
}
