# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXext/libXext-1.1.1.ebuild,v 1.2 2009/10/31 21:42:03 zmedico Exp $

inherit x-modular

DESCRIPTION="X.Org Xext library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEPEND=">=x11-libs/libX11-1.1.99.1"
RDEPEND="${COMMON_DEPEND}
	!<x11-proto/xextproto-7.1.1"
DEPEND="${COMMON_DEPEND}
	>=x11-proto/xextproto-7.0.99.2
	>=x11-proto/xproto-7.0.13"
