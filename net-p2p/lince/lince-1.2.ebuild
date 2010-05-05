# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lince/lince-1.2.ebuild,v 1.1 2010/05/05 21:47:39 sochotnicky Exp $

EAPI="1"

DESCRIPTION="A light, powerful and full-featured gtkmm bittorrent client"
SRC_URI="mirror://sourceforge/lincetorrent/${P}.tar.gz"
HOMEPAGE="http://lincetorrent.sourceforge.net"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus"

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/cairomm
	>=dev-cpp/glibmm-2.16
	>=net-libs/rb_libtorrent-0.13
	>=dev-libs/boost-1.36
	dev-libs/libxml2
	sys-devel/gettext
	dbus? ( dev-libs/dbus-glib )
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-util/intltool"

src_compile() {
	econf $(use_with dbus)
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
