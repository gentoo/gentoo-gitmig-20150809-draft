# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXau/libXau-1.0.5.ebuild,v 1.7 2009/12/15 16:00:03 armin76 Exp $

inherit x-modular

DESCRIPTION="X.Org Xau library"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-proto/xproto"
DEPEND="${RDEPEND}
	>=x11-misc/util-macros-1.2"
