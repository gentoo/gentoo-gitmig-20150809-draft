# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich/mpich-1.2.4.ebuild,v 1.4 2003/09/11 01:29:22 msterret Exp $

S=${WORKDIR}/mpich-${PV}
DESCRIPTION="MPICH - A portable MPI implementation"
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/mpich-${PV}.tar.gz"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="net-misc/openssh"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}

	cd ${S}/romio/util/
	mv romioinstall.in romioinstall.in-orig
	sed -e "s|docdir=\"\$datadir/lam/doc\"|docdir=\"${D}/usr/share/doc/${PF}\"|" romioinstall.in-orig >romioinstall.in

}

src_compile() {
	cd ${S}
	./configure --mandir=/usr/share/man --prefix=/usr || die
	make || die
}

src_install() {
	dodir /usr/sbin
	dodir /usr/local/bin

	make prefix=${D}/usr mandir=${D}/usr/share/man --infodir=/usr/share/infoinstall --sysconfdir=/etc/mpich || die

	dodoc COPYING README

}

