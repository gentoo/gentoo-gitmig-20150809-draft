# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/oww/oww-0.71.1.ebuild,v 1.1 2004/12/27 21:06:40 ribosome Exp $

DESCRIPTION="A one-wire weather station for Dallas Semiconductor"
HOMEPAGE="http://oww.sourceforge.net/"

SRC_URI="mirror://sourceforge/sourceforge/oww/oww-${PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-1.2.10
	gnome-base/libglade
	media-libs/gdk-pixbuf
	>=gnome-base/libghttp-1.0.9"

src_compile() {
	econf --enable-interactive || die "Failed during configure"
	emake || die "Failed during make."
}

src_install () {
	make DESTDIR="${D}" install || die "Failed during install."
	dodoc README* NEWS
}

