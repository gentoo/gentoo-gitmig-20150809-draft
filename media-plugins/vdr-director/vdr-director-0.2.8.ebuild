# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-director/vdr-director-0.2.8.ebuild,v 1.4 2009/04/19 14:05:24 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Director - use the multifeed option of some Premiere channels - Plugin"
HOMEPAGE="http://www.wontorra.net/staticpages/index.php?page=director"
SRC_URI="http://www.wontorra.net/filemgmt_data/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.34"
RDEPEND="${DEPEND}"

