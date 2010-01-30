# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlogo/xlogo-1.0.2.ebuild,v 1.2 2010/01/30 18:35:05 ssuominen Exp $

inherit x-modular

DESCRIPTION="X Window System logo"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXrender
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXft
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--with-render"
