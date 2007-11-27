# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdr-dvd-scripts/vdr-dvd-scripts-0.0.2.ebuild,v 1.5 2007/11/27 10:42:11 zzam Exp $

DESCRIPTION="dvd read/write commands for vdr-plugins dvdselect and dvdswitch"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Dvdselect_readdvd.sh"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=media-tv/gentoo-vdr-scripts-0.3.0-r1
	!>=media-tv/gentoo-vdr-scripts-0.4.1"

src_install() {
	exeinto /usr/share/vdr/dvdchanger
	exeopts -m0755
	doexe "${FILESDIR}"/${PV}/*.sh
}
