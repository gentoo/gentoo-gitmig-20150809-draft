# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/lam-mpi/lam-mpi-6.5.9-r1.ebuild,v 1.2 2004/03/25 07:51:01 mr_bones_ Exp $

IUSE="crypt "

Name="lam"
S=${WORKDIR}/${Name}-${PV}

DESCRIPTION="the LAM MPI parallel computing environment"
SRC_URI="http://www.lam-mpi.org/download/files/${Name}-${PV}.tar.bz2"
HOMEPAGE="http://www.lam-mpi.org"

DEPEND="virtual/glibc
	!sys-cluster/mpich"
# we need ssh if we want to use it instead of rsh
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )"

SLOT="6"
KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="as-is"

PROVIDE="dev-libs/lam-mpi"

src_unpack() {
	unpack ${A}

	cd ${S}/romio/util/
	mv romioinstall.in romioinstall.in-orig
	sed -e "s|docdir=\"\$datadir/lam/doc\"|docdir=\"${D}/usr/share/doc/${PF}\"|" romioinstall.in-orig >romioinstall.in

}

src_compile() {

	local myconf

	if use crypt; then
		myconf="--with-rsh=ssh"
	else
		myconf="--with-rsh=rsh"
	fi

	econf --with-cflags="${CFLAGS}" \
		--sysconfdir=/etc/lam-mpi \
		--with-cxxflags="${CXXFLAGS}" ${myconf} || die

	# sometimes emake doesn't finish since it gets ahead of itself :)

	make || die

}

src_install () {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc/lam-mpi install || die

	#need to correct the produced absolute symlink
	cd ${D}/usr/include
	rm mpi++.h
	ln -sf mpi2c++/mpi++.h mpi++.h

	dodoc README HISTORY LICENSE RELEASE_NOTES VERSION
}
