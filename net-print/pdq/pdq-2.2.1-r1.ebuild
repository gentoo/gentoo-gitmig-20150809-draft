# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pdq/pdq-2.2.1-r1.ebuild,v 1.11 2004/06/15 02:49:15 agriffis Exp $

IUSE="gtk"

DESCRIPTION="A non-daemon-centric print system which has a built-in, and sensible, driver configuration syntax."
SRC_URI="http://pdq.sourceforge.net/ftp/${P}.tgz"
HOMEPAGE="http://pdq.sourceforge.net"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	econf || die "econf failed"
	if use gtk; then
		echo "Making pdq and xpdq"
		make -C ${S}/src || die
	else
		echo "Making only pdq (xpdq disabled)"
		make -C ${S}/src pdq || die
	fi
	make -C ${S}/lpd || die
}

src_install () {
	cd ${S}/src
	exeinto /usr/bin
	if use gtk ; then
		doexe pdq xpdq || die
	else
		doexe pdq || die
	fi

	cd ${S}/lpd
	exeopts -m 4755 -o root
	exeinto /usr/bin
	doexe lpd_cancel lpd_print lpd_status || die

	cd ${S}/doc
	if use gtk ; then
		echo "man w/ gtk"
		doman *.1 *.5 || die
	else
		echo "man w/o gtk"
		doman lpd_cancel.1 lpd_print.1 lpd_status.1 pdq.1 pdqstat.1 \
			printrc.5 || die
	fi
	dodoc rfc1179.txt || die

	cd ${S}/etc
	sed -i -e 's/$$dir/$(DESTDIR)$$dir/' \
		-e 's/$(pdqlibdir)\/$$file/$(DESTDIR)\/$(pdqlibdir)\/$$file/' \
		Makefile || die 'sed failed'
	insinto /etc/pdq
	newins printrc.example printrc || die
	make DESTDIR=${D} install || die 'make install failed'

	cd ${S}
	dodoc CHANGELOG INSTALL README LICENSE BUGS || die
}
