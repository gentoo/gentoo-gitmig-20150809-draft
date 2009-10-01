# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libax25/libax25-0.0.11-r2.ebuild,v 1.3 2009/10/01 12:39:15 ssuominen Exp $

DESCRIPTION="AX.25 protocol library for various Amateur Radio programs"
HOMEPAGE="http://ax25.sourceforge.net/"
SRC_URI="mirror://sourceforge/ax25/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install installconf || die
	dodoc AUTHORS NEWS README || die
}
