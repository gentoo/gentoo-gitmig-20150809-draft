# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-neomagic/xf86-video-neomagic-1.2.6.ebuild,v 1.1 2012/03/24 16:27:43 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Neomagic video driver"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
