# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ermixer/ermixer-0.7.1.ebuild,v 1.2 2003/01/06 01:41:39 agenkin Exp $

DESCRIPTION="A full featured console-based audio mixer."
HOMEPAGE="http://ermixer.sourceforge.net"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
KEYWORDS="x86"

SRC_URI="mirror://sourceforge/ermixer/${P}.tar.gz"
S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
