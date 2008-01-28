# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-chanman/vdr-chanman-0.0.6.ebuild,v 1.2 2008/01/28 16:18:52 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: change channel with a multi level choice."
HOMEPAGE="http://www.messinalug.org/${PN}/"
SRC_URI="http://www.messinalug.org/${PN}/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"
