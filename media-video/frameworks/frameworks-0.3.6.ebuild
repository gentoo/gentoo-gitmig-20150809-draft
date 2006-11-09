# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/frameworks/frameworks-0.3.6.ebuild,v 1.1 2006/11/09 19:30:04 aballier Exp $

DESCRIPTION="A small v4l frame capture utility especially suited for stop motion animation."
SRC_URI="http://frameworks.polycrystal.org/release/${P}.tar.gz"
HOMEPAGE="http://frameworks.polycrystal.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86 ~amd64"

IUSE=""
DEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
