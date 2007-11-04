# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.7.2.ebuild,v 1.6 2007/11/04 11:05:46 opfer Exp $

inherit eutils

DESCRIPTION="A Query Object Framework"
HOMEPAGE="http://qof.sourceforge.net/"
SRC_URI="mirror://sourceforge/qof/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"

IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-remove_spurious_CFLAGS.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
