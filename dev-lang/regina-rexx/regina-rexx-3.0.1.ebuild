# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.0.1.ebuild,v 1.1 2002/07/20 03:49:46 george Exp $

S="${WORKDIR}"
HOMEPAGE="http://regina-rexx.sourceforge.net"
DESCRIPTION="Portable Rexx interpreter"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/regina-rexx/regina301.zip"
RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	autoconf || die "autoconf problem"
	./configure --prefix=/usr --mandir=/usr/share/man || die "configure problem"
	mv Makefile Makefile~
	sed <Makefile~ >Makefile \
		-e 's|-$(INSTALL) -m 755 -c ./rxstack.init.d $(STARTUPDIR)/rxstack||' \
		-e "s|/usr/share/regina|${D}/usr/share/regina|"
	emake || die "make problem"
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share/regina install || die "install problem"

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
