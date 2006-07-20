# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.3.90.2.ebuild,v 1.2 2006/07/20 07:45:51 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 print manager panel plugin"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="lpr"

RDEPEND="!lpr? ( net-print/cups )
	lpr? ( net-print/lprng )
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

if use lpr; then
	XFCE_CONFIG="${XFCE_CONFIG} $(use_enable lpr bsdlpr)"
else
	XFCE_CONFIG="${XFCE_CONFIG} --enable-cups"
fi

xfce44_core_package
