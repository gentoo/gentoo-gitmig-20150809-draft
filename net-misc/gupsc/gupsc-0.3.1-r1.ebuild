# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupsc/gupsc-0.3.1-r1.ebuild,v 1.11 2003/09/05 22:01:48 msterret Exp $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="A Gnome client for the Network UPS Tools (nut)"
SRC_URI="http://www.stud.ifi.uio.no/~hennikul/gupsc/download/${P}.tar.bz2"
HOMEPAGE="http://www.stud.ifi.uio.no/~hennikul/gupsc/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	# nls sandboxes
	econf --disable-nls || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}



