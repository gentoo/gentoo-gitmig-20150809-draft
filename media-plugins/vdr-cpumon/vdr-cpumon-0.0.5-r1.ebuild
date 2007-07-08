# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cpumon/vdr-cpumon-0.0.5-r1.ebuild,v 1.1 2007/07/08 21:23:00 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Show cpu-usage on OSD"
HOMEPAGE="ftp://ftp.eui.fh-koblenz.de/pub/studenten/Philipp.Glass/vdr"
SRC_URI="ftp://ftp.eui.fh-koblenz.de/pub/studenten/Philipp.Glass/vdr/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.44"

PATCHES="${FILESDIR}/${P}-vdr-1.5.diff"

