# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ferrisloki/ferrisloki-3.0.3.ebuild,v 1.2 2010/08/21 16:57:07 vapier Exp $

EAPI="2"

DESCRIPTION="Loki C++ library from Modern C++ Design"
HOMEPAGE="http://www.libferris.com/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="stlport"

RDEPEND="stlport? ( >=dev-libs/STLport-4.5.3-r3 )
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# derice this damn configure script
	sed -i \
		-e '/^CFLAGS/{s: -O3 : :g;s:-Wl,-O1 -Wl,--hash-style=both::;}' \
		configure
}

src_configure() {
	econf $(use_enable stlport)
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
