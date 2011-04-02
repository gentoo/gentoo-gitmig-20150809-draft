# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifiscanner/wifiscanner-1.0.1-r1.ebuild,v 1.3 2011/04/02 12:49:04 ssuominen Exp $

MY_P=WifiScanner-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="WifiScanner is an analyzer and detector of 802.11b stations and access points."
HOMEPAGE="http://wifiscanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/wifiscanner/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="wireshark ncurses"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND="wireshark? ( net-analyzer/wireshark )
	ncurses? ( sys-libs/ncurses )
	net-libs/libpcap
	dev-libs/glib"
DEPEND="${RDEPEND}"

src_compile () {
	econf \
		$(use_enable ncurses curses) \
		$(use_with !wireshark internal-wiretap) \
		--enable-wtap || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS BUG-REPORT-ADDRESS ChangeLog FAQ NEWS THANKS TODO doc/*
}
