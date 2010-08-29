# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-appfinder/xfce4-appfinder-4.6.2.ebuild,v 1.8 2010/08/29 17:59:26 armin76 Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Application finder"
HOMEPAGE="http://www.xfce.org/projects/xfce4-appfinder"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.12:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4menu-4.6
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	<xfce-base/thunar-1.1.0"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}
