# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ktrack/ktrack-0.3.0_rc1.ebuild,v 1.1 2004/06/29 05:08:01 killsoft Exp $

inherit kde
need-kde 3

MY_P=${P/_r/-r}
DESCRIPTION="Amateur radio satellite prediction software"
HOMEPAGE="http://ktrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
S="${WORKDIR}/${MY_P}"

newdepend "x11-misc/xplanet media-libs/hamlib"
