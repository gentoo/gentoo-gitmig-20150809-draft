# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-nettool/gnome-nettool-3.0.0-r1.ebuild,v 1.1 2011/11/07 02:16:10 tetromino Exp $

EAPI="4"
GNOME_TARBALL_SUFFIX="bz2"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}-patches-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

COMMON_DEPEND="
	>=dev-libs/glib-2.25.10
	>=x11-libs/gtk+-2.90.4:3
	gnome-base/libgtop:2"
RDEPEND="${COMMON_DEPEND}
	|| ( net-analyzer/traceroute sys-freebsd/freebsd-usbin )
	net-dns/bind-tools
	userland_GNU? ( net-misc/netkit-fingerd net-misc/whois )
	userland_BSD? ( net-misc/bsdwhois )"

# Gilles Dartiguelongue <eva@gentoo.org> (12 Apr 2008)
# Mask gnome-system-tools 2.14 because it is starting to cause more headache
# to keep it than to mask it.
# Support is autodetected at runtime anyway.
# app-admin/gnome-system-tools

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.9
	app-text/gnome-doc-utils
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		$(use_enable debug)
		--disable-schemas-compile
		--disable-scrollkeeper"
}

src_prepare() {
	# Useful upstream patches
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
	gnome2_src_prepare
}
