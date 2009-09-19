# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xf86vidmodeproto/xf86vidmodeproto-2.2.99.1.ebuild,v 1.1 2009/09/19 14:44:20 remi Exp $

EAPI="2"

inherit x-modular

DESCRIPTION="X.Org XF86VidMode protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
>=x11-misc/util-macros-1.2
!<x11-libs/libXxf86vm-1.0.99.1"
