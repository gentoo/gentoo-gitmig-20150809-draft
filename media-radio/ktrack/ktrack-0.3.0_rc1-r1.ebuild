# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ktrack/ktrack-0.3.0_rc1-r1.ebuild,v 1.3 2006/10/30 10:15:50 flameeyes Exp $

inherit kde

MY_P=${P/_r/-r}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Amateur radio satellite prediction software"
HOMEPAGE="http://ktrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktrack/${MY_P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
IUSE=""

RDEPEND="x11-misc/xplanet
	media-libs/hamlib"
DEPEND="${RDEPEND}"
need-kde 3

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${PN}-time_include_fix.diff"
}
