# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/lam-mpi/lam-mpi-7.1.1-r3.ebuild,v 1.1 2005/08/15 03:30:47 kugelfang Exp $

inherit fortran flag-o-matic

# LAM is a PITA with PBS. If it's detected, there is NO way to turn it off!
# Likewise for the other SSI boot modules (globus/slurm/tm are affected)
IUSE="crypt pbs fortran"

MY_P=${P/-mpi}
S=${WORKDIR}/${MY_P}

DESCRIPTION="the LAM MPI parallel computing environment"
SRC_URI="http://www.lam-mpi.org/download/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.lam-mpi.org"
PROVIDE="virtual/mpi"
DEPEND="virtual/libc
		pbs? ( virtual/pbs )
		!virtual/mpi"
# we need ssh if we want to use it instead of rsh
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )"

SLOT="6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="as-is"

src_unpack() {
	unpack ${A}

	# Fixes BUG #88110.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/08/15
	epatch ${FILESDIR}/${P}-shared-romio.patch
	cd ${S}/romio/util/
	sed -i "s|docdir=\"\$datadir/lam/doc\"|docdir=\"${D}/usr/share/doc/${PF}\"|" romioinstall.in

	for i in ${S}/share/memory/{ptmalloc,ptmalloc2,darwin7}/Makefile.in; do
	  sed -i -e 's@^\(docdir = \)\$(datadir)/lam/doc@\1'/usr/share/doc/${PF}'@' ${i}
	done
}

pkg_setup() {
	: # make sure fortran_pkg_setup does NOT run
}

src_compile() {

	local myconf

	if use crypt; then
		myconf="${myconf} --with-rsh=ssh"
	else
		myconf="${myconf} --with-rsh=rsh"
	fi

	use pbs && append-ldflags -L/usr/lib/pbs

	if use fortran; then
		fortran_pkg_setup
		# this is NOT in pkg_setup as it is NOT needed for RDEPEND right away it
		# can be installed after merging from binary, and still have things fine
		myconf="${myconf} --with-fc=${FORTRANC}"
	else
		myconf="${myconf} --without-fc"
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
	# They are replicated in the pdfs! Thus remove this comment?
	dodoc README HISTORY LICENSE VERSION
	cd ${S}/doc
	dodoc {user,install}.pdf

	# install examples
	cd ${S}/examples
	mkdir -p ${D}/usr/share/${P}/examples
	find -name README -or -iregex '.*\.[chf][c]?$' >${T}/testlist
	while read p; do
		cp --parents $p ${D}/usr/share/${P}/examples;
	done < ${T}/testlist
}
