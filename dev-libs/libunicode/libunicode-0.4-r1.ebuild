# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunicode/libunicode-0.4-r1.ebuild,v 1.33 2009/07/29 22:28:22 vostorga Exp $

inherit toolchain-funcs

DESCRIPTION="Unicode library"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.gnome.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sparc x86"
IUSE=""

src_compile() {
	econf || die
	emake CC=$(tc-getCC) || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
