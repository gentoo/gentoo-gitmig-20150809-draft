# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnobog/gnobog-0.4.3.ebuild,v 1.11 2004/07/14 15:26:11 agriffis Exp $

DESCRIPTION="Gnome Bookmarks Organizer"
HOMEPAGE="http://www.nongnu.org/gnobog/"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND=">=gnome-base/libglade-0.17-r5"

src_compile() {
	econf \
		--includedir=/usr/include/libglade-1.0 || die "configure failed"

	emake || die "Compile failed"
}

src_install () {
	einstall || die "install failed"
	dodoc ChangeLog README
}
