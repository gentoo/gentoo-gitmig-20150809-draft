# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/shtool/shtool-1.5.1-r2.ebuild,v 1.1 2001/11/10 00:08:06 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A compilation of small but very stable and portable shell scripts into a single shell tool"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/shtool/${P}.tar.gz
	 ftp://ftp.gnu.org/gnu/shtool/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/shtool/shtool.html"

DEPEND=">=sys-devel/perl-5.6"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man
	assert

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     install || die

	dodoc AUTHORS ChangeLog COPYING README THANKS VERSION
}

