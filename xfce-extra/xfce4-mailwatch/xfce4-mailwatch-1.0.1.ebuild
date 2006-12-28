# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mailwatch/xfce4-mailwatch-1.0.1.ebuild,v 1.1 2006/12/28 03:09:03 nichoj Exp $

inherit xfce44

xfce44_beta
xfce44_panel_plugin

DESCRIPTION="Xfce4 mail notification panel plugin"
HOMEPAGE="http://spuriousinterrupt.org/projects/mailwatch"
SRC_URI="http://spuriousinterrupt.org/files/mailwatch/${MY_P}.tar.bz2"
KEYWORDS="~x86"

IUSE="ssl"

DEPEND=">=dev-util/intltool-0.31
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/gtk+-2.4
	>=xfce-base/libxfce4util-4.2
	>=xfce-base/libxfcegui4-4.2
	ssl? ( >=net-libs/gnutls-1.2 )"

XFCE_CONFIG="$(use_enable ssl)"
