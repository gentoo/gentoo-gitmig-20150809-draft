# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/ristretto/ristretto-0.0.19.ebuild,v 1.1 2008/05/13 23:51:21 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="a fast and lightweight picture-viewer for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/ristretto"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}${COMPRESS}"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.12
	dev-libs/dbus-glib
	media-libs/libexif
	>=sys-apps/dbus-1
	>=xfce-extra/exo-0.3.2
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
