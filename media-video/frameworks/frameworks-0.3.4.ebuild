# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/frameworks/frameworks-0.3.4.ebuild,v 1.1 2005/03/28 03:23:40 chriswhite Exp $

DESCRIPTION="A small v4l frame capture utility especially suited for stop motion animation."
SRC_URI="http://www.polycrystal.org/software/frameworks/${P}.tar.gz"
HOMEPAGE="http://www.polycrystal.org/software/frameworks.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
