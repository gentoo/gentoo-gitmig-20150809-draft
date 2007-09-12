# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/ristretto/ristretto-0.0.4.ebuild,v 1.1 2007/09/12 16:55:40 drac Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="a fast and lightweight picture-viewer for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/ristretto"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

KEYWORDS="~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.12
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README"
