# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrandr/libXrandr-1.3.0.ebuild,v 1.11 2009/12/15 19:38:23 ranger Exp $

inherit x-modular

DESCRIPTION="X.Org Xrandr library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	>=x11-proto/randrproto-1.3
	x11-proto/xproto"
DEPEND="${RDEPEND}
	x11-proto/renderproto
	x11-proto/xextproto"
