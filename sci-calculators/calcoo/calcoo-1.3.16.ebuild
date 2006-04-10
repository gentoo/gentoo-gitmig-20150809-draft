# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/calcoo/calcoo-1.3.16.ebuild,v 1.1 2006/04/10 00:08:01 cryos Exp $

IUSE=""

DESCRIPTION="Scientific calculator designed to provide maximum usability"
HOMEPAGE="http://calcoo.sourceforge.net/"
SRC_URI="mirror://sourceforge/calcoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf --disable-gtktest || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	make DESTDIR=${D} install || die "make install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
