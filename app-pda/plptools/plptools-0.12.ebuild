# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plptools/plptools-0.12.ebuild,v 1.3 2004/06/26 23:09:25 liquidx Exp $

inherit eutils

DESCRIPTION="Libraries and utilities to communicate with a Psion palmtop via serial."
HOMEPAGE="http://plptools.sourceforge.net"
SRC_URI="mirror://sourceforge/plptools/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
DEPEND="kde? ( >=kde-base/kdelibs-3.1* )"

IUSE="kde"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-assert.h.patch
}

src_compile() {
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
