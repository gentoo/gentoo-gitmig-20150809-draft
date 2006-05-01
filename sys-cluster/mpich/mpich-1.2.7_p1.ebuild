# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich/mpich-1.2.7_p1.ebuild,v 1.3 2006/05/01 11:51:12 corsair Exp $

inherit eutils

# Set the MPICH_CONFIGURE_OPTS environment variable to change the signal
# mpich listens on or any other custom options (#38207).
# The default USR1 conflicts with pthreads. Options include SIGUSR2 and SIGBUS.
# For example: MPICH_CONFIGURE_OPTS="--with-device=ch_p4:-listener_sig=SIGBUS"

MY_P="${PN}-${PV/_}"

DESCRIPTION="MPICH - A portable MPI implementation"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich"
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE="doc crypt"

PROVIDE="virtual/mpi"
DEPEND="virtual/libc
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
	!virtual/mpi
	|| ( x11-libs/libX11
		virtual/x11 )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if [ -n "${MPICH_CONFIGURE_OPTS}" ]; then
		einfo "Custom configure options are ${MPICH_CONFIGURE_OPTS}."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	grep -FrlZ '$(P) ' . | xargs -0 sed -i -e 's/\$(P)//'

	# Fix broken romio
	epatch ${FILESDIR}/${PV}-fix-romio-sandbox-breakage.patch
	cd ${S}/romio
	rm configure
	autoreconf --install --verbose
}

src_compile() {
	local RSHCOMMAND

	if use crypt; then
		RSHCOMMAND="ssh -x"
	else
		RSHCOMMAND="rsh"
	fi

	export RSHCOMMAND

	local myconf="${myconf} ${MPICH_CONFIGURE_OPTS}"

	./configure \
		${myconf} \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--datadir=/usr/share/mpich || die
	emake -j1 || die
}

src_install() {
	dodir /usr/sbin

	# mpich install process is really weird, need to do some hand work perhaps

	# to skip installation of man pages, uncomment following line
	# export MPIINSTALL_OPTS=-noman

	./bin/mpiinstall -echo -prefix=${D}/usr || die

	if use doc; then
		dodir /usr/share/doc/${PF}
		mv ${D}/usr/doc/* ${D}/usr/share/doc/${PF}
	fi
	rm -rf ${D}/usr/doc/

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
	dosed /usr/bin/clog2TOslog2 /usr/bin/clog2print
	dosed /usr/bin/clogTOslog2 /usr/bin/clogprint
	dosed /usr/bin/jumpshot /usr/bin/logconvertor
	dosed /usr/bin/mpicc /usr/bin/mpiCC /usr/bin/logviewer
	dosed /usr/bin/mpicxx
	dosed /usr/bin/mpireconfig /usr/bin/mpireconfig.dat
	dosed /usr/bin/mpereconfig /usr/bin/mpereconfig.dat
	dosed /usr/bin/rlogTOslog2 /usr/bin/rlogprint
	dosed /usr/bin/slog2navigator /usr/bin/slog2print

	dosed /usr/share/mpich/examples1/Makefile
	dosed /usr/share/mpich/examples2/Makefile
	dosed /usr/share/mpich/jumpshot-3/bin/jumpshot
	dosed /usr/share/mpich/jumpshot-3/bin/slog_print
	dosed /usr/share/mpich/Makefile.sample
	dosed /usr/share/mpich/upshot/bin/upshot

	# Fix datadir; mpich's build system screws it up even though we pass it
	grep -rl 'datadir=.*' ${D} \
		| xargs sed -i -e "s:datadir=.*:datadir=/usr/share/mpich:g"

	# those are dangling symlinks
	rm -f \
		${D}/usr/share/mpich/examples1/mpirun \
		${D}/usr/share/mpich/examples2/mpirun

	mv ${D}/usr/man ${D}/usr/share/man
	prepallman

	#FIXME: Here, we should either clean the empty directories
	# or use keepdir to make sure they stick around.
}

pkg_postinst() {
	einfo "The data directory has moved from /usr/share"
	einfo "to /usr/share/mpich."
	einfo "Remeber to move your machines.* files."
}
