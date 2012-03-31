# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.7.0.ebuild,v 1.1 2012/03/31 05:53:33 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-volman"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug libnotify"

COMMON_DEPEND=">=dev-libs/glib-2.18
	|| ( >=sys-fs/udev-171-r5[gudev] <sys-fs/udev-171-r5[extras] )
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/exo-0.7
	>=xfce-base/libxfce4ui-4.9
	>=xfce-base/libxfce4util-4.9
	>=xfce-base/xfconf-4.9
	libnotify? ( >=x11-libs/libnotify-0.7 )"
RDEPEND="${COMMON_DEPEND}
	>=xfce-base/thunar-1.3[udev]"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		$(use_enable libnotify notifications)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README THANKS )
}
