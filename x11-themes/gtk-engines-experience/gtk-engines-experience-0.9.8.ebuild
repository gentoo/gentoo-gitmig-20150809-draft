# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-experience/gtk-engines-experience-0.9.8.ebuild,v 1.1 2005/08/07 11:47:34 leonardop Exp $

MY_PN="experience"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="GTK+2 Experience Theme Engine"
HOMEPAGE="http://benjamin.sipsolutions.net/Projects/eXperience"
SRC_URI="http://benjamin.sipsolutions.net/${MY_PN}/${MY_P}.tar.bz2"

KEYWORDS="~ppc ~x86 ~sparc"
IUSE="static"
LICENSE="GPL-2"
SLOT="2"

RDEPEND=">=x11-libs/gtk+-2.6"
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

	dodoc AUTHORS ChangeLog NEWS README TODO
}
