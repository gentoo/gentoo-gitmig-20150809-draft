# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.0.1.ebuild,v 1.9 2004/04/26 17:51:45 agriffis Exp $

S=${WORKDIR}
HOMEPAGE="http://regina-rexx.sourceforge.net"
DESCRIPTION="Portable Rexx interpreter"
SRC_URI="mirror://sourceforge/regina-rexx/regina301.zip"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"

DEPEND="app-arch/unzip"

src_compile() {
	autoconf || die "autoconf problem"
	econf || die "econf failed"
	mv Makefile Makefile~
	sed <Makefile~ >Makefile \
		-e 's|-$(INSTALL) -m 755 -c ./rxstack.init.d $(STARTUPDIR)/rxstack||' \
		-e "s|/usr/share/regina|${D}/usr/share/regina|"
	emake || make || die "make problem"
}

src_install() {
	einstall datadir=${D}/usr/share/regina || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/rc_rxstack rxstack

	dodoc BUGS COPYING-LIB HACKERS.txt README.Unix README_SAFE \
		TODO demo
}

pkg_postinst() {
	einfo "You may want to run"
	einfo ""
	einfo "\trc-update add rxstack default"
	einfo ""
	einfo "to enable Rexx queues (optional)."
}
