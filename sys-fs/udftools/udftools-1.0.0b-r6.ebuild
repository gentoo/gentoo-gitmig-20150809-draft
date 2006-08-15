# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udftools/udftools-1.0.0b-r6.ebuild,v 1.3 2006/08/15 10:23:21 dsd Exp $

inherit eutils

MY_P="${P}3"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
SRC_URI="mirror://sourceforge/linux-udf/${MY_P}.tar.gz
	http://w1.894.telia.com/~u89404340/patches/packet/${MY_P}.patch.bz2"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# For new kernel packet writing driver
	epatch ${WORKDIR}/${MY_P}.patch

	# Fix CD blanking for 2.6.8 and newer
	epatch ${FILESDIR}/cdrwtool-linux2.6-fix-v2.patch

	# gcc4 compat, bug #112122
	epatch ${FILESDIR}/${P}-gcc4.patch

	# BE fix, bug #120245
	epatch ${FILESDIR}/${P}-bigendian.patch
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING
	newinitd ${FILESDIR}/pktcdvd.init pktcdvd
}

