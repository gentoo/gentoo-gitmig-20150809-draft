# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/stickers/stickers-0.1.3-r1.ebuild,v 1.2 2004/01/24 13:53:26 mr_bones_ Exp $


DESCRIPTION="Stickers Book for small children"
HOMEPAGE="http://users.powernet.co.uk/kienzle/stickers/"
SRC_URI="http://users.powernet.co.uk/kienzle/stickers/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND="virtual/x11
	media-libs/imlib
	x11-libs/gtk+
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die
	emake || die "emake failed"
}

src_install () {
	make \
		prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man install || die "make install failed"
}
