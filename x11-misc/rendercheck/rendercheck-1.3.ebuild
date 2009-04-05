# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rendercheck/rendercheck-1.3.ebuild,v 1.3 2009/04/05 18:52:47 tester Exp $

IUSE=""

DESCRIPTION="Tests for compliance with X RENDER extension"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://xorg.freedesktop.org/releases/individual/app/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ppc ~x86"

RDEPEND=">=x11-base/xorg-x11-6.8.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
}
