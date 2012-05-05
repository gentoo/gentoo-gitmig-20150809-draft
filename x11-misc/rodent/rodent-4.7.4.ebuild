# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rodent/rodent-4.7.4.ebuild,v 1.2 2012/05/05 04:53:43 jdhore Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A fast, small and powerful file manager and graphical shell"
HOMEPAGE="http://rodent.xffm.org/"
SRC_URI="mirror://sourceforge/xffm/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=dev-libs/glib-2.20.5
	dev-libs/libxml2
	>=dev-libs/libzip-0.9
	>=gnome-base/librsvg-2.26
	sys-apps/file
	>=x11-libs/cairo-1.8.10
	>=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	x11-libs/libSM"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( ChangeLog README TODO )
}

src_install() {
	# Build/share/Makefile.am:docdir = $(datadir)/doc/@PLUGIN_DIR@
	xfconf_src_install docdir=/usr/share/doc/${PF}
}
