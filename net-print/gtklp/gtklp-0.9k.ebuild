# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.9k.ebuild,v 1.6 2003/02/13 15:25:15 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI for cupsd"
SRC_URI="http://www.stud.uni-hannover.de/~sirtobi/gtklp/files/${P}.src.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~sirtobi/gtklp"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7"

src_compile() {
	local myconf=""
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	use ssl \
		&& myconf="${myconf} --enable-ssl" \
		|| myconf="${myconf} --disable-ssl"

	econf ${myconf}
	emake || make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}
