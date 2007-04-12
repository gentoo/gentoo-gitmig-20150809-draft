# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ufo/ufo-0.8.4.ebuild,v 1.1 2007/04/12 19:54:50 jokey Exp $

DESCRIPTION="A platform and device independent core library for GUIs"
HOMEPAGE="http://libufo.sourceforge.net/"
SRC_URI="mirror://sourceforge/libufo/$P.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	x11-libs/libICE"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
