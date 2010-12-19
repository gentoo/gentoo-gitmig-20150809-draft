# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rendercheck/rendercheck-1.4.ebuild,v 1.2 2010/12/19 12:44:55 ssuominen Exp $

EAPI=3

MODULE="app"
XORG_STATIC=no
inherit xorg-2

DESCRIPTION="Tests for compliance with X RENDER extension"

KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXrender
	x11-libs/libX11"
DEPEND="${RDEPEND}"
