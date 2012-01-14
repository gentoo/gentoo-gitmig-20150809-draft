# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifiscanner/wifiscanner-1.0.1-r2.ebuild,v 1.3 2012/01/14 05:28:15 vapier Exp $

EAPI="4"

inherit autotools

MY_P=WifiScanner-${PV}
DESCRIPTION="analyzer and detector of 802.11b stations and access points"
HOMEPAGE="http://wifiscanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/wifiscanner/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ncurses wireshark"

RDEPEND="wireshark? ( net-analyzer/wireshark )
	ncurses? ( sys-libs/ncurses )
	net-libs/libpcap
	dev-libs/glib"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e '/^gentoo_ltmain_version=/s|:space:|[:space:]|g' \
		$(find -name configure) || die #349770
}

src_configure() {
	econf \
		$(use_enable ncurses curses) \
		$(use_enable wireshark wtap) \
		--without-internal-wiretap \
		--with-wtap_path=/usr/include/wiretap
}

src_install() {
	default
	dodoc BUG-REPORT-ADDRESS
}
