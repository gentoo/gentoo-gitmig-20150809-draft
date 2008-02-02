# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-filebrowser/vdr-filebrowser-0.0.6b.ebuild,v 1.1 2008/02/02 20:51:16 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: file manager plugin for moving or renaming files in VDR."
HOMEPAGE="http://www.stud.uni-karlsruhe.de/~uqg8/vdr/filebrowser/"
SRC_URI="http://www.stud.uni-karlsruhe.de/~uqg8/vdr/filebrowser/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"

src_unpack() {
	vdr-plugin_src_unpack

	if has_version ">=media-video/vdr-1.5.0"; then
		epatch "${FILESDIR}"/vdr-filebrowser-0.0.6b_vdr-1.5.diff
		epatch "${FILESDIR}"/vdr-filebrowser-0.0.6b-typofix.diff
	fi
}

src_install() {
	vdr-plugin_src_install

	insinto	/etc/vdr/plugins/filebrowser
	doins   "${FILESDIR}"/commands.conf
	doins   "${FILESDIR}"/order.conf
	doins   "${FILESDIR}"/othercommands.conf
	doins   "${FILESDIR}"/sources.conf
}
