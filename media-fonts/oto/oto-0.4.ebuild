# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oto/oto-0.4.ebuild,v 1.3 2004/06/24 22:30:28 agriffis Exp $

DESCRIPTION="Open Type Organizer"
HOMEPAGE="http://sourceforge.net/projects/oto/"
SRC_URI="mirror://sourceforge/oto/oto-0.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
