# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-experience/gtk-engines-experience-0.9.7.ebuild,v 1.2 2005/08/04 15:15:30 dholm Exp $

inherit eutils

MY_P="experience-${PV}"
DESCRIPTION="GTK+2 Experience Theme Engine"
HOMEPAGE="http://art.gnome.org/themes/gtk_engines/1057"
SRC_URI="http://art.gnome.org/download/themes/gtk_engines/1057/${MY_P}.tar.bz2"

KEYWORDS="~ppc ~x86"
IUSE="static"
LICENSE="GPL-2"
SLOT="2"

RDEPEND=">=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-mem_fixes.patch
}

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
