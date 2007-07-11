# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-experience/gtk-engines-experience-0.10.4.ebuild,v 1.2 2007/07/11 13:15:45 gustavoz Exp $

MY_PN="experience"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="GTK+2 Experience Theme Engine"
HOMEPAGE="http://benjamin.sipsolutions.net/Projects/eXperience"
SRC_URI="http://benjamin.sipsolutions.net/${MY_PN}/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~ppc sparc ~x86 ~x86-fbsd"
IUSE=""
LICENSE="LGPL-2"
SLOT="2"

RDEPEND=">=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

S="${WORKDIR}/${P/engines/engine}"

src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
