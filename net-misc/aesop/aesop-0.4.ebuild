# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aesop/aesop-0.4.ebuild,v 1.9 2004/07/15 02:33:02 agriffis Exp $


DESCRIPTION="Aesop is a TCP-proxy which supports many advanced and powerful features.  Uses encryption and provides a wrapper library for BSD socket API."
SRC_URI="http://kryptology.org/aesop/download/${P}.tar.gz"
HOMEPAGE="http://kryptology.org/aesop"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="sys-devel/gcc"

src_compile() {
	./configure --enable-ipv6 --enable-libaesop --prefix=/usr

	mv ${S}/src/Rules.make ${S}/src/Rules.make.old
	sed "s/CFLAG=-O2/CFLAG=${CFLAGS}/" ${S}/src/Rules.make.old > ${S}/src/Rules.make
	cat ${S}/src/Rules.make

	make aesopd aesoptunnel libaesop keygen  || die
}

src_install() {
	# name is too generic... might be used by a more common package
	mv ${S}/keygen ${S}/aesopkeygen

	dobin aesopd
	dobin aesoptunnel
	dobin aesopkeygen

	dolib libaesop.so.0

	dodoc BUILDING Changelog LICENSE README routes.example runaesop.sh
}
