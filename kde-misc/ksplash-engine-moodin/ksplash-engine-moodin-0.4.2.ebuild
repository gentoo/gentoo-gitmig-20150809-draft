# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksplash-engine-moodin/ksplash-engine-moodin-0.4.2.ebuild,v 1.6 2007/02/12 16:08:57 jokey Exp $

inherit kde

MY_P=${P/moodin-0/moodin_0}
S=${WORKDIR}/moodin

DESCRIPTION="Splash Screen Engine for KDE - Heavily customizable engine for various types of themes"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=25705"
SRC_URI="http://moodwrod.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE="arts"

DEPEND="|| ( kde-base/ksplashml kde-base/kdebase )"

need-kde 3.4

src_compile() {
	econf $(use_with arts) || die "econf failed"
	emake || die "emake failed"
}
