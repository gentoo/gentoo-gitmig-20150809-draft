# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.3.90.1.ebuild,v 1.1 2006/04/20 05:45:26 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 print manager panel plugin"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="lpr cups"

RDEPEND="cups? ( net-print/cups )
	!cups? ( lpr? ( net-print/lprng ) )
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	media-libs/libpng
	net-libs/gnutls
	app-text/a2ps"
DEPEND="${RDEPEND}
	~xfce-base/xfce-mcs-manager-${PV}"

XFCE_CONFIG="$(use_enable cups)"

if ! use cups; then
	XFCE_CONFIG="${XFCE_CONFIG} $(use_enable lpr bsdlpr)"
fi

xfce44_core_package
