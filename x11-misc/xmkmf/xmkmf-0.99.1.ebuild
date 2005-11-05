# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmkmf/xmkmf-0.99.1.ebuild,v 1.4 2005/11/05 15:12:57 geoman Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org imake tool for turning Imakefiles into Makefiles"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
RDEPEND="x11-misc/imake"
DEPEND="${RDEPEND}"

PATCHES=""
