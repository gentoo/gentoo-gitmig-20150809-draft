# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/desktop-file-utils/desktop-file-utils-0.7.ebuild,v 1.5 2004/09/02 23:00:11 gustavoz Exp $

DESCRIPTION="Command line utilities to work with desktop menu entries"
SRC_URI="http://www.freedesktop.org/software/desktop-file-utils/releases/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/software/desktop-file-utils/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0.0
		>=dev-libs/popt-1.6.3"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"


src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
