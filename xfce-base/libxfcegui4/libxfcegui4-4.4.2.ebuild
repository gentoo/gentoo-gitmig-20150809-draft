# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.4.2.ebuild,v 1.3 2007/12/09 20:36:04 dertobi123 Exp $

inherit xfce44

XFCE_VERSION=4.4.2
xfce44

DESCRIPTION="Unified widgets library"
HOMEPAGE="http://www.xfce.org/projects/libraries"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug doc startup-notification"

RDEPEND="x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package
