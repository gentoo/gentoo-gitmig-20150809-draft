# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.2.4.ebuild,v 1.1 2004/10/28 21:22:42 motaboy Exp $

inherit kde-base

S="${WORKDIR}/${PN}"

DESCRIPTION="kio slave to search files with locate"
SRC_URI="http://www.arminstraub.de/downloads/kio_locate/${PN}_${PV}.tar.gz"
HOMEPAGE="http://arminstraub.de/browse.php?doc=kio_locate"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="sys-apps/slocate"

need-kde 3.1