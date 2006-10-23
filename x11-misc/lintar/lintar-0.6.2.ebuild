# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lintar/lintar-0.6.2.ebuild,v 1.3 2006/10/23 07:02:55 omp Exp $

DESCRIPTION="A decompressing tool written in GTK+."
HOMEPAGE="http://lintar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog README NEWS TODO
}
