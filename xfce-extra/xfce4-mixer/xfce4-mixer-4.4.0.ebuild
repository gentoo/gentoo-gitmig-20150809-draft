# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.4.0.ebuild,v 1.3 2007/01/23 22:45:03 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 mixer with panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="alsa debug"

RDEPEND=">=dev-libs/glib-2
	dev-libs/libxml2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	media-libs/libpng
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}"

if use alsa; then
	XFCE_CONFIG="--with-sound=alsa"
fi

xfce44_core_package
