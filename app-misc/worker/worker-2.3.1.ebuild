# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.3.1.ebuild,v 1.8 2003/02/13 09:12:58 vapier Exp $

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone."
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.boomerangsworld.de/worker/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	econf
	emake || die "Parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS
}
