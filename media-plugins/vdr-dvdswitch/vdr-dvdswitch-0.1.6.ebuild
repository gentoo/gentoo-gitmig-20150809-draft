# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvdswitch/vdr-dvdswitch-0.1.6.ebuild,v 1.1 2011/01/24 00:22:31 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

VERSION="445" # every bump, new version

DESCRIPTION="vdr plugin to play dvds and dvd file structures"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-dvdswitch"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="media-plugins/vdr-dvd"

DEFAULT_IMAGE_DIR="/var/vdr/video/dvd-images"

VDR_CONFD_FILE="${FILESDIR}/0.1.3/confd-r2"

src_prepare() {
	vdr-plugin_src_prepare

	sed -e "s:/video/dvd:${DEFAULT_IMAGE_DIR}:" -i setup.c
}
