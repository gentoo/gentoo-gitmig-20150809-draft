# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/beforelight/beforelight-0.99.3.ebuild,v 1.1 2005/12/04 21:40:57 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org beforelight application"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXt
	x11-libs/libXaw"
DEPEND="${RDEPEND}"
