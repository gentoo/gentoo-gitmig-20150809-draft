# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdmx/libdmx-1.1.1.ebuild,v 1.2 2010/11/01 14:27:59 scarabeus Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org dmx library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-proto/xextproto
	>=x11-proto/dmxproto-2.3"
DEPEND="${RDEPEND}"
