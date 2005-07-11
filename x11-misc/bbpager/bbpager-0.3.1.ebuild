# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.3.1.ebuild,v 1.8 2005/07/11 22:59:17 swegener Exp $

IUSE=""
DESCRIPTION="An understated pager for Blackbox."
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbpager"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64"

DEPEND="virtual/blackbox"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README TODO NEWS ChangeLog
}
