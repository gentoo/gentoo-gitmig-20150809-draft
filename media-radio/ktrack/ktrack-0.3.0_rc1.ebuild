# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ktrack/ktrack-0.3.0_rc1.ebuild,v 1.3 2004/08/04 23:13:26 killsoft Exp $

inherit kde

MY_P=${P/_r/-r}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Amateur radio satellite prediction software"
HOMEPAGE="http://ktrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktrack/${MY_P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

RDEPEND="x11-misc/xplanet
	media-libs/hamlib"
need-kde 3

