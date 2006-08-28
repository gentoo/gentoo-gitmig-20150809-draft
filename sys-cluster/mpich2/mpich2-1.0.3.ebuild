# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich2/mpich2-1.0.3.ebuild,v 1.7 2006/08/28 16:45:22 dberkholz Exp $

inherit eutils autotools kde-functions

DESCRIPTION="MPICH2 - A portable MPI implementation"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich2"
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
# need more arches in here...
IUSE="crypt cxx doc debug mpe threads"

PROVIDE="virtual/mpi"
DEPEND="virtual/libc
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"
RDEPEND="${DEPEND}
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
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
	cd ${S}
	need-autoconf 2.5
	ebegin "Reconfiguring"
	    ./maint/updatefiles
	eend "Reconfigure failed"
	epatch ${FILESDIR}/${P}-make.patch || die "make patch failed"
	# damn, have to patch the createshlib script here...
	epatch ${FILESDIR}/${P}-soname.patch || die "soname patch failed"

}

src_compile() {
	export LDFLAGS='-Wl,-z,now'
	local RSHCOMMAND

	if use crypt ; then
		RSHCOMMAND="ssh -x"
	else
		RSHCOMMAND="rsh"
	fi
	export RSHCOMMAND

	local myconf="${MPICH_CONFIGURE_OPTS}"

	if ! use debug ; then
	    myconf="${myconf} --enable-fast --enable-g=none"
	else
	    myconf="${myconf} --enable-g=dbg --enable-debuginfo"
	fi

	if use threads ; then
	    myconf="${myconf} --with-thread-package=pthreads"
	else
	    myconf="${myconf} --with-thread-package=none"
	fi

	./configure --prefix=/usr --enable-sharedlibs=gcc \
		${myconf} --enable-rlog=no --enable-slog2=no \
		$(use_enable cxx) \
		$(use_enable mpe) \
		$(use_enable threads) \
		--includedir=/usr/include \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		--sysconfdir=/etc/mpich2 \
		--datadir=/usr/share/mpich2 || die "configure failed"

	if use mpe ; then
	     epatch ${FILESDIR}/${P}-mpe-install.patch || die "install patch failed"
	fi

	make || die "make failed"
}

src_install() {
	dodir /etc/${PN}
	rm -rf src/mpe2/etc/*.in
	make install DESTDIR=${D} LIBDIR=${D}usr/$(get_libdir) \
	    || die "make install failed"

	dodir /usr/share/${PN}
	mv ${D}usr/examples/cpi ${D}usr/share/${PN}/cpi
	rm -rf ${D}/usr/examples
	rm -rf ${D}usr/sbin

	dodir /usr/share/doc/${PF}
	if use doc; then
		dodoc COPYRIGHT README README.romio README.testing CHANGES
		dodoc README.developer RELEASE_NOTES
		newdoc src/pm/mpd/README README.mpd
	else
		rm -rf ${D}usr/share/doc/
		rm -rf ${D}usr/share/man/
		dodoc README CHANGES COPYRIGHT RELEASE_NOTES
	fi
}
