# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/tilda/tilda-0.9.4.ebuild,v 1.2 2007/03/25 19:43:09 ticho Exp $

DESCRIPTION="A drop down terminal, similar to the consoles found in first person shooters"
HOMEPAGE="http://tilda.sourceforge.net"
SRC_URI="mirror://sourceforge/tilda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/vte
	>=dev-libs/glib-2.8.4
	dev-libs/confuse"

src_install() {
	emake DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README TODO
}
