# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libroadnav/libroadnav-0.14.ebuild,v 1.1 2006/07/23 13:25:15 kloeri Exp $

DESCRIPTION="LibRoadnav is a library capable of plotting street maps and providing driving directions for US addresses"
HOMEPAGE="http://roadnav.sourceforge.net"
SRC_URI="mirror://sourceforge/roadnav/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.6.2-r1"

src_compile() {
	econf \
	--with-wx-config=wx-config-2.6 \
	--with-wx-config-path=/usr/bin \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
