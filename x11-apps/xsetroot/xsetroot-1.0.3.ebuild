# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsetroot/xsetroot-1.0.3.ebuild,v 1.3 2009/12/10 18:51:38 fauli Exp $

inherit x-modular

DESCRIPTION="X.Org xsetroot application"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="x11-libs/libXmu
	x11-libs/libX11
	x11-misc/xbitmaps"
DEPEND="${RDEPEND}"
