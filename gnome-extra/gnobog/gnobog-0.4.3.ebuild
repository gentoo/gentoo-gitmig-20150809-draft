# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnobog/gnobog-0.4.3.ebuild,v 1.8 2003/09/08 05:22:59 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Bookmarks Organizer"
HOMEPAGE="http://www.nongnu.org/gnobog/"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

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
