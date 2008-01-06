# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ferrisloki/ferrisloki-3.0.1.ebuild,v 1.1 2008/01/06 01:18:08 vapier Exp $

DESCRIPTION="Loki C++ library from Modern C++ Design"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="stlport"

DEPEND="stlport? ( >=dev-libs/STLport-4.5.3-r3 )
	=dev-libs/libsigc++-1.2*"

src_compile() {
	econf $(use_enable stlport) || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
