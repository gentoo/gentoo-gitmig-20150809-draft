# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.66.ebuild,v 1.7 2005/02/19 08:06:50 corsair Exp $

DESCRIPTION="MS-Explorer like file manager for X"
HOMEPAGE="http://sourceforge.net/projects/xfe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ppc64"
IUSE="nls"

# fox-1.1* is incompatible
DEPEND="=x11-libs/fox-1.0*"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ README TODO NEWS
}
