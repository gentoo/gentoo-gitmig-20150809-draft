# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rendercheck/rendercheck-1.0.3.ebuild,v 1.1 2004/11/06 00:19:02 spyderous Exp $

IUSE=""

DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://freedesktop.org/~xapps/release/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

RDEPEND=">=x11-base/xorg-x11-6.8.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
}
