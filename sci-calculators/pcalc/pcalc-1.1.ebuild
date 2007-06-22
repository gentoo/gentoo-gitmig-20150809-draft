# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/pcalc/pcalc-1.1.ebuild,v 1.1 2007/06/22 06:21:47 vapier Exp $

inherit eutils

DESCRIPTION="the programmers calculator"
HOMEPAGE="http://pcalc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcalc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake install DESTDIR="${D}" || die "dobin pcalc"
	dodoc AUTHORS ChangeLog EXAMPLE README
}
