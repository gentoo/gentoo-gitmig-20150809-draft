# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-minicmd/xfce4-minicmd-0.3.0-r1.ebuild,v 1.11 2006/12/28 04:40:30 nichoj Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel command line plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND=">=xfce-base/xfce4-session-4.1.90"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
	x11-libs/libX11 )
	virtual/x11 )"

goodies_plugin

