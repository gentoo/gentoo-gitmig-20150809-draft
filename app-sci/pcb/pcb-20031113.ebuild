# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pcb/pcb-20031113.ebuild,v 1.3 2004/04/19 12:10:16 phosphan Exp $

DESCRIPTION="PCB is a tool for the layout of printed circuit boards."
HOMEPAGE="http://sourceforge.net/projects/pcb/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/x11"
IUSE=""
SLOT="0"

src_compile() {
	econf || die
	cd ${S}
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
}
