# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.7.2.ebuild,v 1.3 2012/12/24 18:41:44 pinkbyte Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Ncurses based monitor for IEEE 802.11 wireless LAN cards"
HOMEPAGE="http://eden-feed.erg.abdn.ac.uk/wavemon/"
SRC_URI="http://eden-feed.erg.abdn.ac.uk/wavemon/stable-releases/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

IUSE="caps"
DEPEND="sys-libs/ncurses
	caps? ( sys-libs/libcap )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.7-dont-override-CFLAGS.patch"
	eautoreconf

	# automagic on libcap, discovered in bug #448406
	use caps || export ac_cv_lib_cap_cap_get_flag=false
}

src_install() {
	emake DESTDIR="${D}" install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog README
}
