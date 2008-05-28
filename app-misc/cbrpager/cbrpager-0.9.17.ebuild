# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cbrpager/cbrpager-0.9.17.ebuild,v 1.3 2008/05/28 16:18:34 pva Exp $

inherit eutils

DESCRIPTION="a simple comic book pager."
HOMEPAGE="http://cbrpager.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="|| ( app-arch/unrar app-arch/unrar-gpl app-arch/rar )
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-zip-filen-escape.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO
	make_desktop_entry ${PN} "CBR Pager" ${PN} "Graphics;Viewer;Amusement;GTK"
}
