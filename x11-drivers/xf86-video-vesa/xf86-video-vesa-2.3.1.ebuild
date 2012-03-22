# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vesa/xf86-video-vesa-2.3.1.ebuild,v 1.1 2012/03/22 21:46:22 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Generic VESA video driver"
KEYWORDS="-* ~alpha ~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
