# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/tasks/tasks-0.16.ebuild,v 1.3 2010/06/29 15:39:28 ssuominen Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="A small, lightweight to-do list for Gnome"
HOMEPAGE="http://pimlico-project.org/tasks.html"
SRC_URI="http://pimlico-project.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.8
	>=x11-libs/gtk+-2.16
	>=dev-libs/glib-2.14
	>=dev-libs/libunique-1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	>=dev-util/intltool-0.33.0
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --with-unique --enable-gtk"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}
