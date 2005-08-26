# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-flat/gtk-engines-flat-2.0-r2.ebuild,v 1.2 2005/08/26 13:48:49 agriffis Exp $

inherit gnuconfig

MY_PN="gtk-flat-theme"
MY_P=${MY_PN}-${PV}
DESCRIPTION="GTK+2 Flat Theme Engine"
SRC_URI="http://download.freshmeat.net/themes/gtk2flat/gtk2flat-default.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/gtk2flat/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="2"
IUSE="static"

RDEPEND=">=x11-libs/gtk+-2"

DEPEND="${REPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	if [[ ${ARCH} == "amd64" ]]; then
		gnuconfig_update ${WORKDIR}
	fi
}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS README
}
