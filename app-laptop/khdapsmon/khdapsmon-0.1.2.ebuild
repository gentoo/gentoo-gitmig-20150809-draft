# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/khdapsmon/khdapsmon-0.1.2.ebuild,v 1.2 2008/11/22 18:12:23 maekke Exp $

inherit kde

MY_P="${P/-/_}"
RELNR="2"

DESCRIPTION="KDE-based monitor for the IBM HDAPS system."
HOMEPAGE="http://www.oakcourt.dyndns.org/projects/khdapsmon/"
SRC_URI="http://www.oakcourt.dyndns.org/projects/khdapsmon/${MY_P}-${RELNR}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

need-kde 3.5
