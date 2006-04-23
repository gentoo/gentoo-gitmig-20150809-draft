# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/x11/x11-7.0-r2.ebuild,v 1.1 2006/04/23 07:40:33 spyderous Exp $

DESCRIPTION="Virtual for the core X11 implementation"
HOMEPAGE="http://www.gentoo.org/proj/en/desktop/x/x11/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""
RDEPEND="app-text/rman
			>=x11-base/xorg-x11-7
			x11-apps/xdm
			x11-apps/xdpyinfo
			x11-apps/xrdb
			x11-apps/xsetroot
			x11-libs/libFS
			x11-libs/liboldX
			x11-libs/libXevie
			x11-libs/libXprintAppUtil
			x11-libs/libXTrap
			x11-libs/libXvMC
			x11-misc/gccmakedep
			x11-misc/imake
			x11-misc/makedepend
			x11-themes/gentoo-xcursors
			x11-themes/xcursor-themes"
DEPEND="${RDEPEND}"
