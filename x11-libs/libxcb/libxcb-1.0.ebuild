# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxcb/libxcb-1.0.ebuild,v 1.16 2009/05/04 17:08:12 ssuominen Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="http://xcb.freedesktop.org/"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
IUSE=""
LICENSE="X11"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	~x11-proto/xcb-proto-${PV}"
