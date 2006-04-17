# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinclassic/vdr-skinclassic-0.0.1b.ebuild,v 1.3 2006/04/17 13:12:28 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr skin: based on classic vdr design"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Skinclassic-plugin"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.3.27"
