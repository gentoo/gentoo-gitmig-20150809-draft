# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gentoo-artwork-livecd/gentoo-artwork-livecd-2006.1.ebuild,v 1.2 2007/02/15 15:24:50 wolf31o2 Exp $

DESCRIPTION="A collection of Gentoo Linux wallpapers for the LiveCD"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="alpha amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="binchecks strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/pixmaps
	doins -r *
}
