# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/yersinia/yersinia-0.7.ebuild,v 1.4 2009/03/18 19:52:43 rbu Exp $

DESCRIPTION="A layer 2 attack framework"
HOMEPAGE="http://www.yersinia.net/"
SRC_URI="http://www.yersinia.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk ncurses"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.5 )
	gtk? ( =x11-libs/gtk+-2* )
	>=net-libs/libnet-1.1.2
	>=net-libs/libpcap-0.9.4"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--enable-admin \
		$(use_with ncurses) \
		$(use_enable gtk) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doman yersinia.8
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO
}
