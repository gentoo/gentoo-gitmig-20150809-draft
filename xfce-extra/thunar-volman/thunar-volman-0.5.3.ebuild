# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.5.3.ebuild,v 1.1 2010/12/05 16:56:39 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-volman"
SRC_URI="mirror://xfce/src/apps/${PN}/0.5/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug libnotify"

COMMON_DEPEND=">=xfce-base/exo-0.5.3
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.14:2
	>=sys-fs/udev-145[extras]
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/libxfce4util-4.7
	>=xfce-base/xfconf-4.7
	libnotify? ( x11-libs/libnotify )"
RDEPEND="${COMMON_DEPEND}
	>=xfce-base/thunar-1.1.1[udev]"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable libnotify notifications)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
