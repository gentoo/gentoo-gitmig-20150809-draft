# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/beforelight/beforelight-1.0.4.ebuild,v 1.4 2010/12/29 22:20:16 maekke Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Sample implementation of screen saver"
KEYWORDS="amd64 arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXt
	x11-libs/libXaw"
DEPEND="${RDEPEND}"
