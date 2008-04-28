# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-clock/vdr-clock-0.0.5b-r1.ebuild,v 1.5 2008/04/28 08:05:18 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Clock PlugIn"
HOMEPAGE="http://vdr.humpen.at"
SRC_URI="http://vdr.humpen.at/uploads/media/${PN}-0.0.5b1.tgz
		mirror://vdrfiles/${PN}/${PN}-0.0.5b1.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0"

S=${WORKDIR}/clock-0.0.5b1

PATCHES=("${FILESDIR}/${P}-makefile.diff"
	"${FILESDIR}/${P}-gcc4.diff")
