# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.3.80.ebuild,v 1.12 2010/08/10 15:44:10 jer Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-volman"
SRC_URI="mirror://xfce/src/apps/${PN}/0.3/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=dev-libs/dbus-glib-0.34
	>=xfce-base/exo-0.3.8[hal]
	<xfce-base/exo-0.5
	<xfce-base/thunar-1.1.0
	sys-apps/hal"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
