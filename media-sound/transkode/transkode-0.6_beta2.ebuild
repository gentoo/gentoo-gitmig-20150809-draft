# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/transkode/transkode-0.6_beta2.ebuild,v 1.1 2006/11/28 23:43:39 flameeyes Exp $

ARTS_REQUIRED="never"

inherit kde

MY_P="${P/_beta/b}"
S="${WORKDIR}/${PN}"

DESCRIPTION="KDE frontend for various audio transcoding tools"
HOMEPAGE="http://kde-apps.org/content/show.php?content=37669"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"

IUSE="wavpack amarok"

RDEPEND="media-libs/taglib
	amarok? ( media-sound/amarok )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	wavpack? ( media-sound/wavpack )
	media-video/mplayer"

need-kde 3.5

src_compile() {
	local myconf

	myconf="$(use_enable amarok amarokscript)"

	kde_src_compile
}