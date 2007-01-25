# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.4.0.ebuild,v 1.3 2007/01/25 19:27:44 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 Printing System"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug"

RDEPEND="net-print/cups
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	media-libs/libpng
	net-libs/gnutls
	app-text/a2ps"
DEPEND="${RDEPEND}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}"

# CUPS includes support for LPR
XFCE_CONFIG="--enable-bsdlpr --enable-cups"

xfce44_core_package
