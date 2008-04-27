# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmpc/xfmpc-0.0.6.ebuild,v 1.1 2008/04/27 01:55:29 drac Exp $

EAPI=1

inherit xfce44

xfce44
xfce44_goodies

DESCRIPTION="a graphical GTK+ MPD client focusing on low footprint"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfmpc"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=media-libs/libmpd-0.15.0
	>=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.12:2
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README THANKS"
