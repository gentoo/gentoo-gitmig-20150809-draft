# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pcb/pcb-20030815.ebuild,v 1.3 2003/11/27 21:03:01 plasmaroo Exp $

DESCRIPTION="PCB is a tool for the layout of printed circuit boards."
HOMEPAGE="http://sourceforge.net/projects/pcb/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="x11-base/xfree"
SLOT="0"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	cd ${S}
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
}
