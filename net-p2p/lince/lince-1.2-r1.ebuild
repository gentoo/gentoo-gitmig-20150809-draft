# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lince/lince-1.2-r1.ebuild,v 1.1 2010/07/11 17:40:17 sochotnicky Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="A light, powerful and full-featured gtkmm bittorrent client"
SRC_URI="mirror://sourceforge/lincetorrent/${P}.tar.gz"
HOMEPAGE="http://lincetorrent.sourceforge.net"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/cairomm
	>=dev-cpp/glibmm-2.16
	=net-libs/rb_libtorrent-0.14*
	>=dev-libs/boost-1.36
	dev-libs/libxml2
	sys-devel/gettext
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_prepare () {
	# Fix doc installation directory (#298899)
	sed -i "s|/share/doc/lince|/share/doc/lince-${PV}|" Makefile.am

	# Fix double file installation (fails with some coreutils)
	sed -i 's/nova2.py helpers.py/ helpers.py/' data/search_engine/Makefile.am
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
