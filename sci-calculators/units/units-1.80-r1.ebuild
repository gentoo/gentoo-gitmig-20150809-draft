# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-1.80-r1.ebuild,v 1.3 2006/03/07 10:52:30 jer Exp $

inherit eutils

DESCRIPTION="program for units conversion and units calculation"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/units/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 hppa ppc sparc x86"

DEPEND=">=sys-libs/readline-4.1-r2
	>=sys-libs/ncurses-5.2-r3"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/remove-script.patch
	epatch ${FILESDIR}/astronomicalunit.patch
}

src_compile() {
	#Note: the trailing / is required in the datadir path.
	econf --datadir=/usr/share/${PN}/ || die
	emake || die
}

src_install() {
	einstall datadir=${D}/usr/share/${PN}/ || die
	dodoc ChangeLog NEWS README
}
