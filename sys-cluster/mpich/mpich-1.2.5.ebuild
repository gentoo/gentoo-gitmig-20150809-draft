# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich/mpich-1.2.5.ebuild,v 1.1 2003/03/29 07:38:45 george Exp $

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
	#looks like P is one of used vars, need to wrap around build...
	local PSave
	PSave=${P}
	unset P
	./configure \
		--mandir=/usr/share/man \
		--prefix=/usr || die
	make || die
	P=${PSave}
}

src_install() {
	dodir /usr/sbin
	dodir /usr/local/bin

	#mangle P here as well..
	local PSave
	PSave=${P}
	unset P

	#mpic install process is really weird, need to do some hand work perheaps

	#to skip installation of man pages, uncomment following line
	#export MPIINSTALL_OPTS=-noman

	./bin/mpiinstall -prefix=${D}/usr || die

	P=${PSave}

	dodir /usr/share/doc/${PF}
	mv ${D}/usr/doc/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/doc/

	dodir /etc/mpich
	mv ${D}/usr/etc/* ${D}/etc/mpich/
	rmdir ${D}/usr/etc/

	dodir /usr/share/${PN}
	mv ${D}/usr/examples ${D}/usr/share/${PN}/examples1
	mv ${D}/usr/share/examples ${D}/usr/share/${PN}/examples2

	rm -rf ${D}/usr/local
	rm -f ${D}/usr/man/mandesc

	mv ${D}/usr/share/{machines*,jumpshot-3,Makefile.sample,upshot} ${D}/usr/share/${PN}

	dodoc COPYING README
	mv ${D}/usr/www ${D}/usr/share/doc/${PF}/html
}

