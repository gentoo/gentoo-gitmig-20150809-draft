# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gmyclient/gmyclient-0.3.ebuild,v 1.2 2002/12/18 16:43:00 vapier Exp $

DESCRIPTION="Gnome based mysql client"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gmyclient.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE="nls"

DEPEND="( >=gnome-base/gnome-libs-1.2*
		dev-db/mysql )"
RDEPEND="( >=gnome-base/gnome-libs-1.2* )"

src_compile() {
	econf `use_enable nls`
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
