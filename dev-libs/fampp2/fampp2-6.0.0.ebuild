# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fampp2/fampp2-6.0.0.ebuild,v 1.1 2008/06/12 03:57:05 vapier Exp $

DESCRIPTION="C++ wrapper for fam"
HOMEPAGE="http://fampp.sourceforge.net/"
SRC_URI="mirror://sourceforge/fampp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/fam
	dev-libs/STLport
	dev-libs/ferrisloki
	dev-libs/libsigc++
	=dev-libs/glib-2*
	=x11-libs/gtk+-2*"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
