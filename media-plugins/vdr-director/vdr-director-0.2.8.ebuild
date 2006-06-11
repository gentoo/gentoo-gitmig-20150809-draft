# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-director/vdr-director-0.2.8.ebuild,v 1.1 2006/06/11 21:27:36 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Director - use the multifeed option of some Premiere channels - Plugin"
HOMEPAGE="http://www.wontorra.net/staticpages/index.php?page=director"
SRC_URI="http://www.wontorra.net/filemgmt_data/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.34"

