# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-console/vdr-console-0.6.0.ebuild,v 1.3 2006/12/03 14:33:00 zzam Exp $

inherit vdr-plugin eutils

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows linux console on vdr\'s output device"
HOMEPAGE="http://ricomp.de/vdr/"
SRC_URI="http://ricomp.de/vdr/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.36"

PATCHES="${FILESDIR}/${P}-vdr-1.3.18.diff
	${FILESDIR}/${P}-uint64.diff"
