# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.6.4.ebuild,v 1.3 2004/06/24 22:38:32 agriffis Exp $

IUSE=""

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://hocwp.free.fr/xbindkeys/${P}.tar.gz"
HOMEPAGE="http://hocwp.free.fr/xbindkeys/"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT="0"

DEPEND=">=x11-base/xfree-4.1.0
	dev-lang/tk"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	emake DESTDIR=${D} || die

}

src_install() {
	emake DESTDIR=${D} \
		BINDIR=/usr/bin install || die "Installation failed"

}

