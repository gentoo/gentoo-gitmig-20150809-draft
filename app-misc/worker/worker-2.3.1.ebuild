# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.3.1.ebuild,v 1.4 2002/10/04 04:58:15 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone."
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.boomerangsworld.de/worker"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	econf || die
	emake || die "Parallel make failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS
}
