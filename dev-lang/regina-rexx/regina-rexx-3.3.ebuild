# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.3.ebuild,v 1.4 2005/03/29 00:18:16 luckyduck Exp $

S="${WORKDIR}/Regina-${PV}"
HOMEPAGE="http://regina-rexx.sourceforge.net"
DESCRIPTION="Portable Rexx interpreter"
SRC_URI="mirror://sourceforge/regina-rexx/Regina-REXX-${PV}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc hppa ~amd64"
IUSE=""

DEPEND=""

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
	rm -rf ${D}/etc/rc.d

	exeinto /etc/init.d
	doexe ${FILESDIR}/rxstack

	dodoc BUGS COPYING-LIB HACKERS.txt README.Unix README_SAFE TODO
}

pkg_postinst() {
	einfo "You may want to run"
	einfo ""
	einfo "\trc-update add rxstack default"
	einfo ""
	einfo "to enable Rexx queues (optional)."
}
