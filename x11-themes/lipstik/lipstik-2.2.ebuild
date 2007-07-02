# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/lipstik/lipstik-2.2.ebuild,v 1.10 2007/07/02 15:06:52 peper Exp $

inherit kde

KLV=18223
DESCRIPTION="Lipstik is a purified style with many options to tune your
desktop look"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=18223"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KLV}-${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
RESTRICT="mirror ${RESTRICT}"

need-kde 3.3

src_unpack() {
	kde_src_unpack
	cd ${S} && epatch ${FILESDIR}/${P}-lower_case.patch
}
