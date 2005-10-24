# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.0.0.ebuild,v 1.5 2005/10/24 16:58:30 dertobi123 Exp $

inherit kde

DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=sys-devel/gdb-5.0"
need-kde 3


src_unpack() {
	kde_src_unpack
	sed -i -e "s:head -1:head -n 1:" configure*
	make -f admin/Makefile.common || die
}