# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/lam-mpi/lam-mpi-7.1.1-r1.ebuild,v 1.1 2005/07/05 22:21:59 kugelfang Exp $

inherit fortran

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
	!sys-cluster/mpich"

SLOT="6"
KEYWORDS="amd64 ~x86 ~sparc ppc64 ~ppc"
LICENSE="as-is"

src_unpack() {
	unpack ${A}

	# Taken out for the moment. I'll address this as soon as possible.
	# Seems like romio needs (all?) ADIOI libraries built as shared libs
	# as well.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/07/06
	#epatch ${FILESDIR}/${P}-shared-romio.patch
	cd ${S}/romio/util/
	sed -i "s|docdir=\"\$datadir/lam/doc\"|docdir=\"${D}/usr/share/doc/${PF}\"|" romioinstall.in
}

src_compile() {

	local myconf

	if use crypt; then
		myconf="${myconf} --with-rsh=ssh"
	else
		myconf="${myconf} --with-rsh=rsh"
	fi

	econf \
		--sysconfdir=/etc/lam-mpi \
		--enable-shared \
		--with-threads=posix \
		${myconf} || die

	# sometimes parallel doesn't finish since it gets ahead of itself :)

	emake -j1 || die
}

src_install () {

	make DESTDIR="${D}" install || die

	# There are a bunch more tex docs we could make and install too,
	# but they might be replicated in the pdf.
	dodoc README HISTORY LICENSE VERSION
	cd ${S}/doc
	dodoc {user,install}.pdf
}
