# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/gtk-cpuspeedy/gtk-cpuspeedy-0.3.0.ebuild,v 1.1 2005/03/14 23:04:55 ciaranm Exp $

DESCRIPTION="Graphical GTK+-2 frontend for cpuspeedy"
HOMEPAGE="http://cpuspeedy.sourceforge.net/"
SRC_URI="mirror://sourceforge/cpuspeedy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-apps/texinfo
	sys-apps/grep
	dev-util/pkgconfig
	sys-devel/gcc
	dev-libs/glib
	dev-libs/atk
	x11-libs/pango
	virtual/x11
	media-libs/fontconfig
	media-libs/freetype
	sys-libs/zlib
	dev-libs/expat
	virtual/libc
	>=x11-libs/gtk+-2"
RDEPEND=">=sys-apps/cpuspeedy-0.2
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	virtual/libc
	sys-libs/zlib
	virtual/x11
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/gksu"

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL COPYING README TODO
}
