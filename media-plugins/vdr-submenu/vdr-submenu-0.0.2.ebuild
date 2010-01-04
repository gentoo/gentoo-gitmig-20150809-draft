# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-submenu/vdr-submenu-0.0.2.ebuild,v 1.7 2010/01/04 22:51:49 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Reads the menu structure out of a config-file"
HOMEPAGE="http://www.freewebs.com/sadhome"
SRC_URI="http://www.freewebs.com/sadhome/Plugin/Submenu/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 x86"

DEPEND=">=media-video/vdr-1.3.20[submenu]"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-asprintf.patch")
