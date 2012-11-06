# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-7.0.0.ebuild,v 1.1 2012/11/06 21:13:11 chithanh Exp $

EAPI=4

XORG_DRI=always
XORG_EAUTORECONF=yes
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.36[video_cards_radeon]"
DEPEND="${RDEPEND}"
