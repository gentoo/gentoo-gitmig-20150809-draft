# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.2.1.ebuild,v 1.4 2004/03/31 18:48:51 eradicator Exp $

DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="http://mikmod.raphnet.net/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND=">=media-libs/libmikmod-3.1.5"

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS
}
