# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-kvdrmon/vdr-kvdrmon-0.6.ebuild,v 1.1 2006/10/23 18:56:19 hd_brummy Exp $

IUSE=""

inherit vdr-plugin

DESCRIPTION="VDR helper plugin for kvdrmon"
HOMEPAGE="http://vdr-statusleds.sf.net/kvdrmon"
SRC_URI="mirror://sourceforge/vdr-statusleds/${P}.tgz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.0"

PATCHES="${FILESDIR}/${P}-remove-menu-entry.diff"

