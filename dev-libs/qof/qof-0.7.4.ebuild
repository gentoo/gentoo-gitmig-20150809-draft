 # Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.7.4.ebuild,v 1.1 2008/01/30 11:51:06 opfer Exp $

inherit eutils

DESCRIPTION="A Query Object Framework"
HOMEPAGE="http://qof.sourceforge.net/"
SRC_URI="mirror://sourceforge/qof/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"

IUSE=""

DEPEND="gnome-extra/libgda
	=dev-db/sqlite-2*"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-remove_spurious_CFLAGS.patch"
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
}
