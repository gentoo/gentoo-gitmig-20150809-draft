# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/intel-gpu-tools/intel-gpu-tools-1.2.ebuild,v 1.4 2012/06/23 11:14:14 swegener Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="intel gpu userland tools"
KEYWORDS="amd64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND="x11-libs/cairo
	>=x11-libs/libdrm-2.4.31[video_cards_intel]
	>=x11-libs/libpciaccess-0.10"
RDEPEND="${DEPEND}"
