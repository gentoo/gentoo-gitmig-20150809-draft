# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mingetty/mingetty-1.00.ebuild,v 1.2 2002/12/17 06:06:15 sethbc Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A compact getty program for virtual consoles only."
SRC_URI="ftp://ftp.redhat.com/pub/redhat/linux/7.3/en/os/i386/SRPMS/${P}-1.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="app-arch/rpm2targz"
RDEPEND="virtual/glibc"

src_unpack() {
	rpm2targz ${DISTDIR}/${P}-1.src.rpm
	tar zxf ${WORKDIR}/${P}-1.src.tar.gz
	tar zxf ${WORKDIR}/${P}.tar.gz
	patch -p0 < ${P}-opt.patch || die
}

src_compile() {
	emake RPM_OPTS="${CFLAGS}" || die
}

src_install () {
	into /
	dosbin mingetty
	doman mingetty.8
}
