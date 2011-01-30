# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-zappilot/vdr-zappilot-0.0.4.ebuild,v 1.1 2011/01/30 20:52:45 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

VERSION="358"

DESCRIPTION="VDR Plugin: browse fast the EPG information without being forced to switch to a channel"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-zappilot"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	sed -i Makefile -e "s:DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE::"
}
