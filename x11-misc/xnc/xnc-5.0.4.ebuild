# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnc/xnc-5.0.4.ebuild,v 1.3 2004/03/24 21:56:00 weeve Exp $

DESCRIPTION="file manager for X Window system very similar to Norton Commander"
HOMEPAGE="http://xnc.dubna.su/"
SRC_URI="http://xnc.dubna.su/src-5/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="nls"

DEPEND="virtual/x11"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_enable nls` \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO
}
