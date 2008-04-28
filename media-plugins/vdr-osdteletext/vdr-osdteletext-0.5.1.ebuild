# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdteletext/vdr-osdteletext-0.5.1.ebuild,v 1.5 2008/04/28 09:00:41 zzam Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.3.1.ebuild,v 1.1 2003/05/13 09:39:19 fow0ryl Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder OSD-Teletext Plugin"
HOMEPAGE="http://www.wiesweg-online.de/linux/linux.html"
SRC_URI="http://www.wiesweg-online.de/linux/vdr/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.2.5"

PATCHES=("${FILESDIR}/i18n_german_lang.diff")

src_install() {
vdr-plugin_src_install

	# create the teletext directory
	diropts -m755 -ovdr -gvdr
	keepdir /var/cache/${VDRPLUGIN}

}
