# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/lspbs/lspbs-1.0.ebuild,v 1.3 2004/06/24 22:39:07 agriffis Exp $

DESCRIPTION="Displays clear, concise and up-to-date PBS node and CPU usage information."
SRC_URI="http://homepages.inf.ed.ac.uk/s0239160/misc/lspbs/lspbs-${PV}.tar.gz"
HOMEPAGE="http://homepages.inf.ed.ac.uk/s0239160/misc/lspbs/lspbs.html"
IUSE=""

DEPEND="virtual/glibc
		|| ( sys-cluster/torque sys-cluster/openpbs )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

src_compile() {
	cd ${S}
	./configure --mandir=/usr/share/man --prefix=/usr --with-pbs=/usr --with-pbs-src=/usr || die
	make || die
}

src_install() {
	dodir /usr/sbin
	dodir /usr/local/bin

	make install prefix=${D}/usr mandir=${D}/usr/share/man infodir=/usr/share/infoinstall || die

	dodoc COPYING README
	doman lspbs.1
}

