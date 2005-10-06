# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-minicmd/xfce4-minicmd-0.3.0-r1.ebuild,v 1.9 2005/10/06 18:32:39 bcowan Exp $

inherit xfce42

DESCRIPTION="Xfce4 panel command line plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
	x11-libs/libX11 )
	virtual/x11 )"

goodies_plugin

