# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/beforelight/beforelight-1.0.1.ebuild,v 1.8 2010/08/19 00:24:34 robbat2 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="screen saver"
KEYWORDS="arm ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~amd64"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXt
	x11-libs/libXaw"
DEPEND="${RDEPEND}"
