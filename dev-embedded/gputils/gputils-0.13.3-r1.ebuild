# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.13.3-r1.ebuild,v 1.8 2007/02/13 11:49:01 corsair Exp $

DESCRIPTION="Collection of tools including assembler, linker and librarian for PIC microcontrollers."
HOMEPAGE="http://gputils.sourceforge.net/"
SRC_URI="mirror://sourceforge/gputils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO doc/gputils.ps
	insinto /usr/share/doc/${PF}/
	doins doc/gputils.pdf
}
