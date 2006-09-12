# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kaptain/kaptain-0.72.ebuild,v 1.4 2006/09/12 02:43:45 ribosome Exp $

inherit kde-functions eutils

DESCRIPTION="A universal graphical front-end for command line programs"
HOMEPAGE="http://kaptain.sourceforge.net/"
SRC_URI="mirror://sourceforge/kaptain/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="ppc ~sparc x86"

need-qt 3

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ggc4.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
