# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-chtheme/gtk-chtheme-0.3.1.ebuild,v 1.4 2004/06/24 23:28:20 agriffis Exp $

DESCRIPTION="GTK-2.0 Theme Switcher"
HOMEPAGE="http://plasmasturm.org/programs/gtk-chtheme/"
SRC_URI="http://plasmasturm.org/programs/gtk-chtheme/${P}.tar.bz2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}"

src_compile() {
		emake || die
}

src_install() {
		einstall DESTDIR=${D} || die
}
