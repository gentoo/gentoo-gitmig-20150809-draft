# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libicq2000/libicq2000-0.3.2.ebuild,v 1.8 2009/06/18 19:32:14 ssuominen Exp $

EAPI=2
inherit base

DESCRIPTION="ICQ 200x compatible ICQ libraries."
SRC_URI="mirror://sourceforge/libicq2000/${P}.tar.gz"
HOMEPAGE="http://ickle.sf.net"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

RDEPEND="dev-libs/libsigc++:1.0"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_configure() {
	econf \
		--enable-debug
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
