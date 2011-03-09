# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.7.4.ebuild,v 1.3 2011/03/09 18:11:07 ssuominen Exp $

EAPI=2

GCONF_DEBUG=no

inherit eutils gnome2 pax-utils

MY_P=${P/_/-}

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus libnotify networkmanager"

RDEPEND=">=x11-libs/gtk+-2.18.0:2
	>=dev-libs/glib-2.16.0:2
	>=x11-libs/pango-1.4.0
	gnome-base/gconf:2
	dev-libs/libunique
	>=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.19
	>=dev-db/sqlite-3.6.10:3
	>=net-libs/libsoup-2.28.2:2.4
	>=net-libs/webkit-gtk-1.1.11
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	networkmanager? ( net-misc/networkmanager dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog README"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-sm
		--disable-schemas-install
		$(use_enable dbus)
		$(use_enable networkmanager nm)
		$(use_enable libnotify)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	# bug #338213
	# Uses webkit's JIT. Needs mmap('rwx') to generate code in runtime.
	# MPROTECT policy violation. Will sit here until webkit will
	# get optional JIT.
	pax-mark m "${D}"/usr/bin/liferea
}
