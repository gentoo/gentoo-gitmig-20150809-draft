# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.3.4.ebuild,v 1.1 2005/01/27 20:13:46 greg_g Exp $

inherit kde

DESCRIPTION="kio slave to search files with locate"
SRC_URI="http://www.arminstraub.de/downloads/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://arminstraub.de/browse.php?page=programs_kiolocate"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

RDEPEND="sys-apps/slocate"

need-kde 3.1
