# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-filebrowser/vdr-filebrowser-0.2.0.ebuild,v 1.2 2010/12/23 00:17:27 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: file manager plugin for moving or renaming files in VDR."
HOMEPAGE="http://vdr.nasenbaeren.net/filebrowser/"
SRC_URI="http://vdr.nasenbaeren.net/filebrowser/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"
RDEPEND="${DEPEND}"

src_prepare() {
	if has_version ">=sys-libs/glibc-2.10.1"; then
		epatch "${FILESDIR}/${P}-glibc-2.10.diff"
	fi

	vdr-plugin_src_prepare
}

src_install() {
	vdr-plugin_src_install

	insinto	/etc/vdr/plugins/filebrowser
	doins   "${FILESDIR}"/commands.conf
	doins   "${FILESDIR}"/order.conf
	doins   "${FILESDIR}"/othercommands.conf
	doins   "${FILESDIR}"/sources.conf
}
