# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/drgeo/drgeo-0.9.12.ebuild,v 1.6 2004/09/22 19:58:31 hansmi Exp $

DESCRIPTION="Interactive geometry package"
HOMEPAGE="http://www.ofset.org/drgeo"
SRC_URI="mirror://sourceforge/ofset/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"

IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	>=dev-util/guile-1.4"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
