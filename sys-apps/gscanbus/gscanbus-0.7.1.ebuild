# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gscanbus/gscanbus-0.7.1.ebuild,v 1.3 2004/02/15 12:01:38 dholm Exp $

DESCRIPTION="gscanbus is a little bus scanning, testing and topology visualizing tool for the Linux IEEE1394 subsystem"
HOMEPAGE="http://gscanbus.berlios.de/"

SRC_URI="http://download.berlios.de/gscanbus/${P}.tgz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"

KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND=">=sys-libs/libraw1394-0.9.0
	>=gtk+-1.2"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_compile() {

	epatch ${FILESDIR}/gscanbus-0.71-gcc33.patch

	econf || die
	emake || die

}

src_install() {

	dobin gscanbus
	dodir /etc
	cp guid-resolv.conf oui-resolv.conf ${D}/etc
	dodoc README

}
