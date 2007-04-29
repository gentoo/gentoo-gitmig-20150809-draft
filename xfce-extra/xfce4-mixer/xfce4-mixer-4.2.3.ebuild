# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.2.3.ebuild,v 1.13 2007/04/29 15:40:47 drac Exp $

inherit xfce42

DESCRIPTION="Xfce4 mixer panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	~xfce-base/xfce4-panel-${PV}
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}"

use alsa && XFCE_CONFIG="--with-sound=alsa"

core_package
