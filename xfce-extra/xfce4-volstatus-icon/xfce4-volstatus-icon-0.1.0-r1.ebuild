# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-volstatus-icon/xfce4-volstatus-icon-0.1.0-r1.ebuild,v 1.2 2009/08/23 17:54:10 ssuominen Exp $

EAPI="2"

inherit xfce4

DESCRIPTION="Systray status icon for safe unmount/eject of volumes"
HOMEPAGE="http://goodies.xfce.org"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/exo-0.3.2[hal]
	>=sys-apps/hal-0.5.9
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

XFCE4_PATCHES="${FILESDIR}/xfce4-volstatus-icon-0.1.0-dialogsegfault.diff"

DOCS="AUTHORS ChangeLog NEWS README TODO"
