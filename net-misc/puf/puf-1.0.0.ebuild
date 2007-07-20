# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/puf/puf-1.0.0.ebuild,v 1.1 2007/07/20 09:05:58 drizzt Exp $

DESCRIPTION="A download tool for UNIX-like systems."
SRC_URI="mirror://sourceforge/puf/${P}.tar.gz"
HOMEPAGE="http://puf.sourceforge.net/"

DEPEND=""

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
}
