# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plptools/plptools-0.12.ebuild,v 1.1 2004/01/11 01:30:59 tad Exp $

DESCRIPTION="Libraries and utilities to communicate with a Psion palmtop via serial."
HOMEPAGE="http://plptools.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/plptools/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc
		kde? ( >=kde-base/kdelibs-3.1* )"

S="${WORKDIR}/${P}"
IUSE="kde"

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patch failed!"

	local myconf

	if use kde
	then
		myconf="${myconf} --enable-kde"
	else
		myconf="${myconf} --disable-kde"
	fi

	./configure ${myconf} --prefix=/usr || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES README TODO

	insinto /etc/conf.d
	newins ${FILESDIR}/psion.conf psion

	exeinto /etc/init.d
	doexe ${FILESDIR}/psion
}
