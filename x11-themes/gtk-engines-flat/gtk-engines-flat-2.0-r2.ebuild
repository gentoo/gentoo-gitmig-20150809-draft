# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-flat/gtk-engines-flat-2.0-r2.ebuild,v 1.12 2007/01/05 09:25:22 flameeyes Exp $


MY_PN="gtk-flat-theme"
MY_P=${MY_PN}-${PV}
DESCRIPTION="GTK+2 Flat Theme Engine"
SRC_URI="http://download.freshmeat.net/themes/gtk2flat/gtk2flat-default.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/gtk2flat/"

KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"
LICENSE="GPL-2"
SLOT="2"
IUSE="static"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS README
}
