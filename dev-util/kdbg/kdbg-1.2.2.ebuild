# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.2.ebuild,v 1.6 2002/05/27 17:27:38 drobbins Exp $
 
inherit kde-base || die

need-kde 2

DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="mirror://sourceforge/kdbg/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

src_compile() {

	kde_src_compile myconf
	myconf="$myconf --with-kde-version=2"
	kde_src_compile configure make
}
