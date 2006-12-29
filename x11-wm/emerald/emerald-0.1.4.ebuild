# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.1.4.ebuild,v 1.2 2006/12/29 01:05:57 tsunam Exp $

inherit gnome2 

DESCRIPTION="Beryl Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

PDEPEND="=x11-themes/emerald-themes-${PV}"
RDEPEND="x11-libs/pango
	>=x11-libs/gtk+-2.8.0
	>=x11-libs/libwnck-2.14.2
	>=x11-libs/libXrender-0.8.4
	=x11-wm/beryl-core-${PV}"

DEPEND="${RDEPENDS}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35"

pkg_setup() {
	G2CONF="${G2CONF} --disable-mine-update"
}

src_unpack() {
	gnome2_src_unpack
	intltoolize --force || die "intltool failed"
}
