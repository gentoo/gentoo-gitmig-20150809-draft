# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifiscanner/wifiscanner-1.0.1.ebuild,v 1.1 2006/01/02 20:30:16 genstef Exp $

MY_P=WifiScanner-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="WifiScanner is an analyzer and detector of 802.11b stations and access points."
HOMEPAGE="http://wifiscanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/wifiscanner/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="ethereal ncurses"
KEYWORDS="~ppc ~x86"
RDEPEND="ethereal? ( net-analyzer/ethereal )
	ncurses? ( sys-libs/ncurses )
	virtual/libpcap
	dev-libs/glib"
DEPEND="${RDEPEND}"

src_compile () {
	econf \
		$(use_enable ncurses curses) \
		$(use_with !ethereal internal-wiretap) \
		--enable-wtap || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUG-REPORT-ADDRESS ChangeLog FAQ NEWS THANKS TODO doc/*
}
