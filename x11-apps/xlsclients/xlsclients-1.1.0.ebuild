# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlsclients/xlsclients-1.1.0.ebuild,v 1.7 2010/09/19 19:47:34 armin76 Exp $

EAPI=3

XORG_STATIC="no"
inherit xorg-2

DESCRIPTION="X.Org xlsclients application"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
"
DEPEND="${RDEPEND}"
