# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/lam-mpi/lam-mpi-7.0.6.ebuild,v 1.7 2006/12/06 23:39:41 dberkholz Exp $

IUSE="crypt"

MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="the LAM MPI parallel computing environment"
SRC_URI="http://www.lam-mpi.org/download/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.lam-mpi.org"

DEPEND="virtual/libc"
# we need ssh if we want to use it instead of rsh
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
	!sys-cluster/mpich
	!sys-cluster/openmpi
	!sys-cluster/mpich2"

SLOT="6"
KEYWORDS="x86 ppc sparc"
LICENSE="as-is"

src_unpack() {
	unpack ${A}

	cd ${S}/romio/util/
	sed -i "s|docdir=\"\$datadir/lam/doc\"|docdir=\"${D}/usr/share/doc/${PF}\"|" romioinstall.in
}

src_compile() {

	local myconf

	if use crypt; then
		myconf="--with-rsh=ssh"
	else
		myconf="--with-rsh=rsh"
	fi

	econf \
		--sysconfdir=/etc/lam-mpi \
		--enable-shared \
		--enable-long-long \
		--enable-threads=posix \
		--enable-languages=c,c++,f77 \
		--disable-checking  \
		--enable-cstdio=stdio \
		--with-system-zlib \
		--without-fc \
		${myconf} || die

	# sometimes emake doesn't finish since it gets ahead of itself :)

	make || die
}

src_install () {

	make DESTDIR="${D}" install || die

	#need to correct the produced absolute symlink
	cd ${D}/usr/include
	rm mpi++.h
	ln -sf mpi2c++/mpi++.h mpi++.h

	# There are a bunch more tex docs we could make and install too,
	# but they might be replicated in the pdf.
	dodoc README HISTORY LICENSE VERSION
	cd ${S}/doc
	dodoc {user,install}.pdf
}
