# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rendercheck/rendercheck-1.3.ebuild,v 1.6 2009/09/19 21:22:50 remi Exp $

MODULE="app"

inherit x-modular

DESCRIPTION="Tests for compliance with X RENDER extension"

KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libXrender"
DEPEND="${RDEPEND}"
