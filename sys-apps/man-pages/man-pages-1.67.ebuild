# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-pages/man-pages-1.67.ebuild,v 1.5 2004/11/15 18:44:27 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux man pages"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"
SRC_URI="mirror://kernel/linux/docs/manpages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

src_compile() { :; }

src_install() {
	make install prefix="${D}" || die
	dodoc man-pages-*.Announce README
}
