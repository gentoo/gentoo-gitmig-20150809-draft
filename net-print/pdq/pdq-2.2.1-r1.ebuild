# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/pdq/pdq-2.2.1-r1.ebuild,v 1.5 2002/07/14 20:41:22 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A non-daemon-centric print system which has a built-in, and sensible, driver configuration syntax."
SRC_URI="http://pdq.sourceforge.net/ftp/${P}.tgz"
HOMEPAGE="http://pdq.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {

	./configure --prefix=/usr --host=${CHOST} || die
	cd src
	if [ -z "`use gtk`" ] ; then
		echo "Making only pdq (xpdq disabled)"
		make pdq || die
	else
		echo "Making pdq and xpdq"
		make || die
	fi
	cd ..
	cd lpd
	make || die
	cd ..

}

src_install () {

	cd src
	exeinto /usr/bin
	if [ -z "`use gtk`" ] ; then
		doexe pdq
	else
		doexe pdq xpdq
	fi
	cd ..
	cd lpd
	exeopts -m 4755 -o root
	exeinto /usr/bin
	doexe lpd_cancel lpd_print lpd_status
	cd ..
	cd doc
	if [ -z "`use gtk`" ] ; then
		echo "man w/o gtk"
		doman lpd_cancel.1 lpd_print.1 lpd_status.1 pdq.1 pdqstat.1 printrc.5
	else
		echo "man w/ gtk"
		doman *.1 *.5
	fi
	dodoc rfc1179.txt
	cd ..
	cd etc
	mv Makefile Makefile.orig
	sed -e 's/$$dir/$(DESTDIR)$$dir/' -e 's/$(pdqlibdir)\/$$file/$(DESTDIR)\/$(pdqlibdir)\/$$file/' Makefile.orig > Makefile
	insinto /etc/pdq
	newins printrc.example printrc
	make DESTDIR=${D} install || die
	cd ..
	dodoc CHANGELOG INSTALL README LICENSE BUGS

}

