# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.1-r1.ebuild,v 1.1 2002/01/10 23:07:03 hallski Exp $

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.gnu.org/gnu/enscript/${P}.tar.gz"

HOMEPAGE="http:/www.gnu.org/software/enscript/enscript.html"
DESCRIPTION="GNU's enscript is a powerful text-to-postsript converter"

DEPEND="sys-devel/flex
	sys-devel/bison"

src_compile() {

	./configure 	--host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc
	assert

	emake || die
}

src_install () {
	make 	prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		install || die
	
	dodoc AUTHORS COPYING ChangeLog FAQ.html NEWS README* THANKS TODO
}

pkg_postinst() {
	echo "
	Now, customize /etc/enscript.cfg.
	"
}
