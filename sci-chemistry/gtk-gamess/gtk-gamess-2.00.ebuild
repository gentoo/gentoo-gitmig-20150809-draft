# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gtk-gamess/gtk-gamess-2.00.ebuild,v 1.8 2011/03/02 13:21:08 jlec Exp $

EAPI="1"

DESCRIPTION="GUI for GAMESS, a General Atomic and Molecular Electronic Structure System"
HOMEPAGE="http://sourceforge.net/projects/gtk-gamess/"

SRC_URI="mirror://sourceforge/gtk-gamess/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~ppc ~x86"

IUSE=""

RDEPEND="
	gnome-base/libglade:2.0
	x11-libs/gtk+:2
	dev-libs/libxml2:2
	sci-chemistry/gamess"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {

	make DESTDIR="${D}" install || die "install failed"
	dodoc README
}
