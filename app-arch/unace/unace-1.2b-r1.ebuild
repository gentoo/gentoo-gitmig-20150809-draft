# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-1.2b-r1.ebuild,v 1.7 2005/06/21 20:42:12 kugelfang Exp $

inherit eutils

DESCRIPTION="ACE unarchiver"
HOMEPAGE="http://www.winace.com/"
SRC_URI="http://wilma.vub.ac.be/~pdewacht/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 x86 s390 ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp unix/makefile .
	cp unix/gccmaked .
	epatch "${FILESDIR}"/unace-1.2b-CAN-2005-0160-CAN-2005-0161.patch
	epatch "${FILESDIR}"/unace-1.2b-64bit.patch
}

src_compile() {
	sed -i -e "s/^CFLAGS = -O.*/CFLAGS = -Wall ${CFLAGS}/g" \
		-e "s/-DCASEINSENSE//g" \
		makefile

	emake dep || die
	emake || die
}

src_install() {
	dobin unace || die
	dodoc readme.txt changes.log
}
