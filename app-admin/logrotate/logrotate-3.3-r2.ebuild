# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.3-r2.ebuild,v 1.8 2002/07/17 20:43:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Rotates, compresses, and mails system logs"
SRC_URI="ftp://ftp.redhat.com/redhat/linux/code/${PN}/${P}.tar.gz
SLOT="0"
	ftp://ftp.valinux.com/pub/mirrors/redhat/redhat/linux/code/${PN}/${P}.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/admin/logrotate.html"
LICENSE="GPL-2"

DEPEND=">=dev-libs/popt-1.5"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS += -g:CFLAGS += -g ${CFLAGS}:" Makefile.orig > Makefile
	make || die
}

src_install() {

	insinto /usr
	dosbin logrotate
	doman logrotate.8
	dodoc examples/logrotate*

}
