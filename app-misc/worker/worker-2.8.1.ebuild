# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.8.1.ebuild,v 1.1 2003/09/13 18:26:45 port001 Exp $

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone."
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.boomerangsworld.de/worker/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="virtual/x11"

src_compile() {
	econf
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS
}
