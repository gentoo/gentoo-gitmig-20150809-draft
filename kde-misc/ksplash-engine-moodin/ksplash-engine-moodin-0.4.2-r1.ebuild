# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksplash-engine-moodin/ksplash-engine-moodin-0.4.2-r1.ebuild,v 1.1 2007/09/23 21:04:14 philantrop Exp $

inherit kde

MY_P=${P/moodin-0/moodin_0}
S="${WORKDIR}/moodin"

DESCRIPTION="Splash Screen Engine for KDE - Heavily customizable engine for various types of themes"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=25705"
SRC_URI="http://moodwrod.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts"

DEPEND="|| ( kde-base/kdebase kde-base/ksplashml )"

need-kde 3.5

# Fixes bug 191796
PATCHES="${FILESDIR}/${P}-multihead.patch"

src_compile() {
	econf $(use_with arts) || die "econf failed"
	emake || die "emake failed"
}
