# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-1.0.0.ebuild,v 1.10 2007/08/15 04:06:10 jer Exp $

inherit eutils

DESCRIPTION="Dos2Unix text file converter"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="!app-text/dos2unix
	dev-libs/popt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog INSTALL NEWS README TODO
}
