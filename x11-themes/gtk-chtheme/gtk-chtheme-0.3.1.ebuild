# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-chtheme/gtk-chtheme-0.3.1.ebuild,v 1.6 2005/01/20 16:35:48 ka0ttic Exp $

DESCRIPTION="GTK-2.0 Theme Switcher"
HOMEPAGE="http://plasmasturm.org/programs/gtk-chtheme/"
SRC_URI="http://plasmasturm.org/programs/gtk-chtheme/${P}.tar.bz2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}"

src_compile() {
		emake || die
}

src_install() {
		einstall DESTDIR=${D} || die
}
