# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.15.0.ebuild,v 1.25 2005/04/29 00:33:23 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Package Config system that manages compile/link flags for libraries"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE="hardened"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	use ppc64 && use hardened && replace-flags -O[2-3] -O1
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
