# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich/mpich-1.2.5.2.ebuild,v 1.2 2004/03/17 08:16:42 mr_bones_ Exp $

DESCRIPTION="MPICH - A portable MPI implementation"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich"
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${P}.tar.gz"
IUSE="doc crypt"
DEPEND=""
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh ) : ( net-misc/netkit-rsh )
	!dev-libs/lam-mpi
	virtual/glibc"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_compile() {
	#looks like P is one of used vars, need to wrap around build...
	local PSave RSHCOMMAND
	PSave=${P}
	unset P

	if use crypt; then
		RSHCOMMAND="ssh -x"
	else
		RSHCOMMAND="rsh"
	fi

	export RSHCOMMAND

	./configure \
		--mandir=/usr/share/man \
		--prefix=/usr || die
	make || die
	P=${PSave}
}

src_install() {
	dodir /usr/sbin

	#mangle P here as well..
	local PSave
	PSave=${P}
	unset P

	# mpich install process is really weird, need to do some hand work perhaps

	# to skip installation of man pages, uncomment following line
	# export MPIINSTALL_OPTS=-noman

	./bin/mpiinstall -echo -prefix=${D}/usr || die

	P=${PSave}

	if use doc; then
		dodir /usr/share/doc/${PF}
		mv ${D}/usr/doc/* ${D}/usr/share/doc/${PF}
		rmdir ${D}/usr/doc/
	else
		rm -rf ${D}/usr/doc/
	fi

	dodir /etc/mpich
	mv ${D}/usr/etc/* ${D}/etc/mpich/
	rmdir ${D}/usr/etc/

	dodir /usr/share/${PN}
	mv ${D}/usr/examples ${D}/usr/share/${PN}/examples1
	mv ${D}/usr/share/examples ${D}/usr/share/${PN}/examples2

	# rm -rf ${D}/usr/local
	rm -f ${D}/usr/man/mandesc

	mv ${D}/usr/share/{machines*,jumpshot-3,Makefile.sample,upshot} ${D}/usr/share/${PN}

	dodoc COPYRIGHT README
	use doc && \
		mv ${D}/usr/www ${D}/usr/share/doc/${PF}/html || \
			rm -rf ${D}/usr/www

	# Dont let users deinstall without portage
	rm ${D}/usr/sbin/mpiuninstall

	# We dont have a real DESTDIR, so we have to fix all the files
	dosed /usr/bin/mpirun /usr/bin/mpiman /usr/sbin/tstmachines
	dosed /usr/sbin/chkserv /usr/sbin/chp4_servs
	dosed /usr/bin/mpicc /usr/bin/mpiCC /usr/bin/logviewer
	dosed /usr/bin/mpireconfig /usr/bin/mpireconfig.dat
	dosed /usr/bin/mpereconfig /usr/bin/mpereconfig.dat

	dosed /usr/share/mpich/examples1/Makefile
	dosed /usr/share/mpich/examples2/Makefile
	dosed /usr/share/mpich/jumpshot-3/bin/jumpshot
	dosed /usr/share/mpich/jumpshot-3/bin/slog_print
	dosed /usr/share/mpich/Makefile.sample
	dosed /usr/share/mpich/upshot/bin/upshot

	# those are dangling symlinks
	rm ${D}/usr/share/mpich/examples1/mpirun
	rm ${D}/usr/share/mpich/examples2/mpirun
}

