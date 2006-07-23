# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/yersinia/yersinia-0.7.ebuild,v 1.2 2006/07/23 20:54:20 vanquirius Exp $

DESCRIPTION="A layer 2 attack framework"
HOMEPAGE="http://www.yersinia.net/"
SRC_URI="http://www.yersinia.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ncurses gtk"

DEPEND="ncurses? ( >=sys-libs/ncurses-5.5 )
	gtk? ( =x11-libs/gtk+-2* )
	>=net-libs/libnet-1.1.2
	>=net-libs/libpcap-0.9.4"

src_compile() {
	local myconf

	myconf="${myconf} $(use_with ncurses)"
	myconf="${myconf} $(use_enable gtk)"
	myconf="${myconf} --enable-admin"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	doman yersinia.8
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO
}
