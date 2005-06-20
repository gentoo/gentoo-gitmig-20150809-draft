# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rendercheck/rendercheck-1.0.3.ebuild,v 1.4 2005/06/20 00:39:02 wormo Exp $

IUSE=""

DESCRIPTION="Tests for compliance with X RENDER extension"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://freedesktop.org/~xapps/release/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"

RDEPEND=">=x11-base/xorg-x11-6.8.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
}
