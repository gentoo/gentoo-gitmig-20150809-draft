# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.2.ebuild,v 1.11 2003/07/13 23:00:53 vapier Exp $

DESCRIPTION="Key binding editor for enlightenment 16"
SRC_URI="mirror://sourceforge/enlightenment/e16utils/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	>=x11-wm/enlightenment-0.16"

src_compile() {
	emake || die
}

src_install() {
	 dobin e16keyedit
	 dodoc README COPYING ChangeLog AUTHORS
}
