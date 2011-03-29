# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-infosatepg/vdr-infosatepg-0.0.11.ebuild,v 1.2 2011/03/29 19:45:17 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

VERSION="342" # every bump, new version!

DESCRIPTION="VDR Plugin: Reads the contents of infosat and writes the data into the EPG."
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-infosatepg"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	sed '2a\
#include <cctype>' -i global.cpp
}
