# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunicode/libunicode-0.4-r1.ebuild,v 1.32 2007/01/05 07:39:26 flameeyes Exp $

DESCRIPTION="Unicode library"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.gnome.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sparc x86"
IUSE=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
