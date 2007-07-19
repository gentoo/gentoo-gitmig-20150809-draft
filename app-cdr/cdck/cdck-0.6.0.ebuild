# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdck/cdck-0.6.0.ebuild,v 1.1 2007/07/19 09:59:22 zzam Exp $

DESCRIPTION="CD/DVD check tool"
HOMEPAGE="http://swaj.net/unix/index.html#cdck"
SRC_URI="http://swaj.net/unix/cdck/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	emake install DESTDIR="${D}"
	dodoc README ChangeLog AUTHORS THANKS TODO
}

