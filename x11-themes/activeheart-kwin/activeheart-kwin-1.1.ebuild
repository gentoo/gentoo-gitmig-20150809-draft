# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/activeheart-kwin/activeheart-kwin-1.1.ebuild,v 1.3 2004/11/28 10:24:02 centic Exp $

inherit kde-base

need-kde 3.2

MY_P=${P/activeheart-kwin/kwin-activeheart}

S=${WORKDIR}/${MY_P}
KLV=11460
DESCRIPTION="A native KWin window decoration for KDE 3.2."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${MY_P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="$KDEMAJORVER.$KDEMINORVER"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
