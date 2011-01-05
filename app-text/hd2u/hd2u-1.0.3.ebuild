# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-1.0.3.ebuild,v 1.1 2011/01/05 18:24:20 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Dos2Unix like text file converter"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="
	dev-libs/popt"
RDEPEND="${DEPEND}
	!app-text/dos2unix"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog INSTALL NEWS README TODO || die
}
