# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/gsynaptics-mcs-plugin/gsynaptics-mcs-plugin-1.0.0.ebuild,v 1.3 2007/03/10 10:31:11 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="a simple MCS plugin that starts gsynaptics and launches gsynaptics-init"
HOMEPAGE="http://goodies.xfce.org/projects/mcs-plugins/gsynaptics-mcs-plugin"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND=">=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	gnome-extra/gsynaptics"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"
