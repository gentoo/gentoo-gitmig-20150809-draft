# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Niklas Höglund <niklas.hoglund@telia.com>
# $Header : $

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://hocwp.free.fr/xbindkeys/${P}.tar.gz"
HOMEPAGE="http://hocwp.free.fr/xbindkeys/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=x11-base/xfree-4.1.0"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	emake DESTDIR=${D} || die

}

src_install() {
	emake DESTDIR=${D} \
		BINDIR=/usr/bin install || die "Installation failed"

}

