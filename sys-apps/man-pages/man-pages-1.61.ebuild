# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-pages/man-pages-1.61.ebuild,v 1.1 2003/11/13 22:58:43 seemant Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
SRC_URI="mirror://kernel/linux/docs/manpages/${P}.tar.bz2"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa arm ia64"

RDEPEND="sys-apps/man"

src_install() {
	einstall MANDIR=${D}/usr/share/man || die
	dodoc man-pages-*.Announce README
}
