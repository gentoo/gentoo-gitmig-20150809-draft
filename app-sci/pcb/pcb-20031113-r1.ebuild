# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pcb/pcb-20031113-r1.ebuild,v 1.5 2004/05/19 19:58:11 vapier Exp $

DESCRIPTION="tool for the layout of printed circuit boards"
HOMEPAGE="http://pcb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86"
SLOT="0"

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	=dev-lang/tk-8*"

src_compile() {
	econf || die
	emake || die
	sed -i -e 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' \
			doc/pcb.info
}

src_install() {
	make DESTDIR=${D} install || die
}
