# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mboxgrep/mboxgrep-0.7.3.ebuild,v 1.2 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Grep for mbox files"
SRC_URI="mirror://sourceforge/mboxgrep/mboxgrep-0.7.3.tar.gz"
HOMEPAGE="http://mboxgrep.sf.net"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc ChangeLog NEWS TODO README
}
