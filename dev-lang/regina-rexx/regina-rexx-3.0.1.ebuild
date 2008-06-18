# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/regina-rexx/regina-rexx-3.0.1.ebuild,v 1.18 2008/06/18 02:13:54 darkside Exp $

S=${WORKDIR}
HOMEPAGE="http://regina-rexx.sourceforge.net"
DESCRIPTION="Portable Rexx interpreter"
SRC_URI="mirror://sourceforge/regina-rexx/regina301.zip"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf || die "eautoreconf problem"
}

src_compile() {
	econf || die "econf failed"
	mv Makefile Makefile~
	sed <Makefile~ >Makefile \
		-e 's|-$(INSTALL) -m 755 -c ./rxstack.init.d $(STARTUPDIR)/rxstack||' \
		-e "s|/usr/share/regina|${D}/usr/share/regina|"
	emake -j1 || die "make problem"
}

src_install() {
	einstall datadir="${D}/usr/share/regina" || die

	doinitd "${FILESDIR}/rxstack"

	dodoc BUGS COPYING-LIB HACKERS.txt README.Unix README_SAFE \
		TODO demo
}

pkg_postinst() {
	elog "You may want to run"
	elog
	elog "\trc-update add rxstack default"
	elog
	elog "to enable Rexx queues (optional)."
}
