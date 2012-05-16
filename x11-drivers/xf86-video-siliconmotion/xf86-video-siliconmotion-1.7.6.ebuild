# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-siliconmotion/xf86-video-siliconmotion-1.7.6.ebuild,v 1.2 2012/05/16 01:56:12 aballier Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Silicon Motion video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
