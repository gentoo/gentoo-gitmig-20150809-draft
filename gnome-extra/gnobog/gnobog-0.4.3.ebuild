# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnobog/gnobog-0.4.3.ebuild,v 1.10 2004/06/24 22:04:14 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Bookmarks Organizer"
HOMEPAGE="http://www.nongnu.org/gnobog/"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"

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
