# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-cirrus/xf86-video-cirrus-1.5.1.ebuild,v 1.3 2012/11/18 12:14:01 ago Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Cirrus Logic video driver"
KEYWORDS="~alpha amd64 ~ia64 ~ppc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
