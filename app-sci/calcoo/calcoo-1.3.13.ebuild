# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/calcoo/calcoo-1.3.13.ebuild,v 1.2 2002/11/19 10:04:47 george Exp $

IUSE=""

DESCRIPTION="Calcoo is a scientific calculator designed to provide maximum usability"

HOMEPAGE="http://calcoo.sourceforge.net"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/calcoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~sparc64"

DEPEND="=x11-libs/gtk+-1.2*"

S="${WORKDIR}/${P}"

src_compile() {
	econf --disable-gtktest || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
