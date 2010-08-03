# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kephal/kephal-4.4.5.ebuild,v 1.2 2010/08/03 07:43:03 hwoarang Exp $

EAPI="3"

KMNAME="kdebase-workspace"
KMMODULE="libs/kephal"
inherit kde4-meta

DESCRIPTION="Allows handling of multihead systems via the XRandR extension"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-libs/libXrandr
"
DEPEND="${RDEPEND}
	x11-proto/randrproto
"
