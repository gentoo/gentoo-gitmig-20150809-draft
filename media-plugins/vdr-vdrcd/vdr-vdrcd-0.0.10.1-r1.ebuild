# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrcd/vdr-vdrcd-0.0.10.1-r1.ebuild,v 1.4 2007/01/05 16:59:00 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Media Detection Plugin"
HOMEPAGE="http://www.magoa.net/linux"
SRC_URI="http://www.magoa.net/linux/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22"

PATCHES="${FILESDIR}/${P}-mp3ng.diff
	${FILESDIR}/${P}-include-dir.diff"

src_install() {

	vdr-plugin_src_install

	insinto /etc/vdr/commands/
	doins "${FILESDIR}/commands.${VDRPLUGIN}.conf"

	dobin ${FILESDIR}/mount-vdrcd.sh
}


pkg_postinst() {

	vdr-plugin_pkg_postinst

	if ! has_version ">media-plugins/vdr-mp3ng-0.9.12"; then
		echo
		elog "For full mp3 support 'emerge media-plugins/vdr-mp3ng -pv'"
	fi
}
