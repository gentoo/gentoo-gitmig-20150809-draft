# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pcb/pcb-20031113-r1.ebuild,v 1.1 2004/02/23 08:35:32 phosphan Exp $

DESCRIPTION="PCB is a tool for the layout of printed circuit boards."
HOMEPAGE="http://sourceforge.net/projects/pcb/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="x11-base/xfree"
SLOT="0"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	cd ${S}
	emake || die
	sed -i -e 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' \
			doc/pcb.info
}

src_install() {
	emake DESTDIR=${D} install || die
}
