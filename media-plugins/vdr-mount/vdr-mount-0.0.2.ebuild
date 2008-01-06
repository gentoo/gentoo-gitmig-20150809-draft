# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mount/vdr-mount-0.0.2.ebuild,v 1.1 2008/01/06 20:29:16 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: (Un)Mount removable media via osd"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Mount-plugin (german)"
SRC_URI="http://homepages.physik.uni-muenchen.de/~Felix.Rauscher/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"
