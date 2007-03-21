# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/emerald/emerald-0.2.1.ebuild,v 1.1 2007/03/21 03:11:05 tsunam Exp $

inherit gnome2

DESCRIPTION="Beryl Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

PDEPEND="~x11-themes/emerald-themes-${PV}"

RDEPEND=">=x11-libs/gtk+-2.8.0
	>=x11-libs/libwnck-2.14.2
	~x11-wm/beryl-core-${PV}"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35"

pkg_setup() {
	G2CONF="${G2CONF} --disable-mime-update"
}
