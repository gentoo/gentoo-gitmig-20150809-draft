# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/desktop-file-utils/desktop-file-utils-0.5.ebuild,v 1.6 2005/01/08 23:18:40 slarti Exp $

DESCRIPTION="Command line utilities to work with desktop menu entries"
HOMEPAGE="http://www.freedesktop.org/software/desktop-file-utils/"
SRC_URI="http://www.freedesktop.org/software/desktop-file-utils/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0.0
	>=dev-libs/popt-1.6.3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
