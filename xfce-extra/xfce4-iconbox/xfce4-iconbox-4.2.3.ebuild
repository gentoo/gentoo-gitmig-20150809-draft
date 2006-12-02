# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-iconbox/xfce4-iconbox-4.2.3.ebuild,v 1.12 2006/12/02 09:50:20 dev-zero Exp $

inherit xfce42

DESCRIPTION="Xfce 4 icon box"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	~xfce-base/xfce4-panel-${PV}"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

core_package
