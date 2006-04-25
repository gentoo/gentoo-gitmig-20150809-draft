# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diction/diction-1.09.ebuild,v 1.1 2006/04/25 21:06:29 seemant Exp $

DESCRIPTION="Diction and style checkers for english and german texts"
HOMEPAGE="http://www.gnu.org/software/diction/diction.html"
SRC_URI="http://www.moria.de/~michael/diction/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND="virtual/libintl"

src_install() {
	make DESTDIR=${D} install
	dodoc NEWS README
}

