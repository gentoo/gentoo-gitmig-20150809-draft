# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/calcoo/calcoo-1.3.13.ebuild,v 1.4 2002/12/18 14:22:26 vapier Exp $

DESCRIPTION="Calcoo is a scientific calculator designed to provide maximum usability"
HOMEPAGE="http://calcoo.sourceforge.net"
SRC_URI="mirror://sourceforge/calcoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	econf --disable-gtktest
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
