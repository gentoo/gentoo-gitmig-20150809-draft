# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tux/tux-2.2.7.ebuild,v 1.2 2004/09/05 09:52:51 swegener Exp $

DESCRIPTION="kernel level httpd"
HOMEPAGE="http://people.redhat.com/mingo/TUX-patches/"
SRC_URI="http://people.redhat.com/mingo/TUX-patches/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/glib
	dev-libs/popt"

src_compile() {
	emake tux tux2w3c tuxstat TMPDIR=${T} || die
}

src_install() {
	make install TOPDIR=${D} || die
	rm -rf ${D}/etc/{rc.d,sysconfig} ${D}/var/tux
	exeinto /etc/init.d ; newexe ${FILESDIR}/tux.init.d tux
	insinto /etc/conf.d ; newins ${FILESDIR}/tux.conf.d tux

	dodoc NEWS SUCCESS tux.README docs/*.txt
	docinto samples
	dodoc samples/* demo*.c
}
