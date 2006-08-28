# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich2/mpich2-1.0.2_p1.ebuild,v 1.3 2006/08/28 16:45:22 dberkholz Exp $

inherit eutils

# Set the MPICH_CONFIGURE_OPTS environment variable to change the signal
# mpich listens on or any other custom options (#38207).
# The default USR1 conflicts with pthreads. Options include SIGUSR2 and SIGBUS.
# For example: MPICH_CONFIGURE_OPTS="--with-device=ch_p4:-listener_sig=SIGBUS"

DESCRIPTION="MPICH2 - A portable MPI implementation"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich2"
MY_P=${P/_/}
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fast cxx mpe"

PROVIDE="virtual/mpi"
DEPEND="virtual/libc
	sys-devel/libtool"
RDEPEND="${DEPEND}
	!virtual/mpi
	!media-sound/mpd
	!media-sound/mpd-svn"

pkg_setup() {
	if [ -n "${MPICH_CONFIGURE_OPTS}" ]; then
		einfo "Custom configure options are ${MPICH_CONFIGURE_OPTS}."
	fi
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/${MY_P} ${S}
	cd ${S}
}

src_compile() {
	local myconf="${myconf} ${MPICH_CONFIGURE_OPTS}"

	./configure \
		${myconf} \
		$(use_enable fast) \
		$(use_enable cxx) \
		$(use_enable mpe) \
		--mandir=/usr/share/man \
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		--sysconfdir=/etc/mpich2 \
		--prefix=/usr \
		--datadir=/usr/share/mpich2 || die
	make || die
}

src_install() {
	make DESTDIR=${D} \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		htmldir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc/mpich2 \
		prefix=${D}/usr \
		install || die

	# Dont let users deinstall without portage
	rm ${D}/usr/sbin/mpeuninstall

	# Fix broken install scripts
	mv ${D}/usr/doc/jumpshot-4 ${D}/usr/share/doc/${PF}
	mv ${D}/usr/examples/cpi ${D}/usr/share/${PN}/cpi

	# Decide whether to install documentation
	if use doc; then
		dodoc COPYRIGHT README README.romio README.testing CHANGES
	else
		rm -rf ${D}/usr/share/doc/
		rm -rf ${D}/usr/share/man/
	fi

	# Fix up the example code Makefiles
	for DIR in examples_graphics examples_logging; do
		sed -i -e "s:^srcdir *=.*$:srcdir=/usr/share/mpich2/${DIR}:" \
			${D}/usr/share/mpich2/${DIR}/Makefile
	done
}
