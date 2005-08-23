# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/activeheart-kwin/activeheart-kwin-1.1.ebuild,v 1.6 2005/08/23 22:24:35 gustavoz Exp $

inherit kde

MY_P=kwin-activeheart-${PV}
S=${WORKDIR}/${MY_P}
KLV=11460

DESCRIPTION="A native KWin window decoration for KDE 3.2."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/content/files/${KLV}-${MY_P}.tar.bz2"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~sparc"
IUSE=""

need-kde 3.2
