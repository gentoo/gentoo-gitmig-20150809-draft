# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mkcfm/mkcfm-0.99.3-r1.ebuild,v 1.1 2005/12/09 05:58:19 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org mkcfm application"
KEYWORDS="~x86"
# >=x11-libs/libXfont-0.99.3-r1 for always-on cid support
RDEPEND=">=x11-libs/libXfont-0.99.3-r1
	x11-libs/libX11
	x11-libs/libFS"
DEPEND="${RDEPEND}
	x11-proto/fontsproto"
