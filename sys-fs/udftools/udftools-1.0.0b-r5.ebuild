# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udftools/udftools-1.0.0b-r5.ebuild,v 1.2 2005/10/25 20:07:44 dsd Exp $

inherit eutils

MY_P="${P}3"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
SRC_URI="mirror://sourceforge/linux-udf/${MY_P}.tar.gz
	http://w1.894.telia.com/~u89404340/patches/packet/${MY_P}.patch.bz2"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# For new kernel packet writing driver
	epatch ${WORKDIR}/${MY_P}.patch

	# Fix CD blanking for 2.6.8 and newer
	epatch ${FILESDIR}/cdrwtool-linux2.6-fix-v2.patch
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING
	newinitd ${FILESDIR}/pktcdvd.init pktcdvd
}

