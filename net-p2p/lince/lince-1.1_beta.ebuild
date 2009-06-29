# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lince/lince-1.1_beta.ebuild,v 1.1 2009/06/29 12:36:02 yngwin Exp $

EAPI="1"

MY_P="Lince-${PV/_/}"

DESCRIPTION="A light, powerful and full-featured gtkmm bittorrent client"
SRC_URI="mirror://sourceforge/lincetorrent/${MY_P}.tar.gz"
HOMEPAGE="http://lincetorrent.sourceforge.net"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus libnotify"

RDEPEND="dev-cpp/gtkmm:2.4
	dev-cpp/cairomm
	>=dev-cpp/glibmm-2.16
	>=net-libs/rb_libtorrent-0.13
	>=dev-libs/boost-1.36
	dev-libs/libxml2
	sys-devel/gettext
	dbus? ( dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}
	dev-util/intltool"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_with dbus) $(use_with libnotify)
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
