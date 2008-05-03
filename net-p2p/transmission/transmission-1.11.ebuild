# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-1.11.ebuild,v 1.2 2008/05/03 18:03:59 drac Exp $

inherit autotools eutils

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/transmission/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk libnotify"

RDEPEND=">=dev-libs/glib-2.16
		 >=dev-libs/openssl-0.9.8
		 gtk? ( >=x11-libs/gtk+-2.6 )
		 libnotify? ( >=x11-libs/libnotify-0.4.4 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		gtk? ( >=dev-util/intltool-0.35 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo filter.cc >> po/POTFILES.skip
	echo speed-stats.cc >> po/POTFILES.skip
	echo torrent-list.cc >> po/POTFILES.skip
	echo torrent-stats.cc >> po/POTFILES.skip
	echo xmission.cc >> po/POTFILES.skip
	epatch "${FILESDIR}/transmission-1.11-libnotify-option.patch"
	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	econf $(use_with gtk) $(use_enable libnotify) --with-wx-config=no || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS
}
