# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hexcurse/hexcurse-1.55.ebuild,v 1.3 2004/04/19 06:28:56 vapier Exp $

DESCRIPTION="ncurses based hex editor"
HOMEPAGE="http://www.jewfish.net/software/"
SRC_URI="http://www.jewfish.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
