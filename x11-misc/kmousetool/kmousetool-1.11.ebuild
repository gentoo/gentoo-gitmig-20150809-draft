# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/kmousetool/kmousetool-1.11.ebuild,v 1.9 2005/01/14 23:17:15 danarmak Exp $

inherit kde

DESCRIPTION="kmousetool - anti rsi tool"
HOMEPAGE="http://www.mousetool.com"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE=""
DEPEND="!kde-base/kmousetool !>=kde-base/kdeaccessibility-3.4.0_alpha1"
SRC_URI="http://www.mousetool.com/distribution/${P}.tar.gz"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34-fix.patch
}
