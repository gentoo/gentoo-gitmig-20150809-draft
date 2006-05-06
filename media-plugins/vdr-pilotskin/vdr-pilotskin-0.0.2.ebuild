# Copyright 2003-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pilotskin/vdr-pilotskin-0.0.2.ebuild,v 1.2 2006/05/06 15:55:53 zzam Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: fork of vdr-pilot - navigate through channels with skinnable design"
HOMEPAGE="http://vdrwiki.free.fr/vdr/pilotskin/"
SRC_URI="http://vdrwiki.free.fr/vdr/pilotskin/files/${P}.tgz"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.36"

