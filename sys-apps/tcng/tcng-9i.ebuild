# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcng/tcng-9i.ebuild,v 1.1 2003/12/17 11:58:17 robbat2 Exp $

DESCRIPTION="tcng - Traffic Control Next Generation"
HOMEPAGE="http://tcng.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc tcsim"

# perl because stuff is written in it
# iproute,linux-atm as the output needs that
# os-headers as it compiles stuff with them
# gcc/binutils as it compiles stuff
DEPEND_COMMON="dev-lang/perl
				sys-apps/iproute
				net-dialup/linux-atm
				virtual/os-headers
				sys-devel/gcc
				sys-devel/binutils"

DEPEND="doc? ( virtual/ghostscript app-text/tetex media-gfx/transfig )
	sys-devel/make
	dev-util/yacc
	sys-devel/flex
	${DEPEND_COMMON}"
RDEPEND="sys-devel/gcc
	tcsim? ( media-gfx/gnuplot )
	sys-apps/grep
	sys-apps/sed
	sys-apps/gawk
	sys-apps/coreutils
	${DEPEND_COMMON}"

IPROUTE_PN="iproute"
IPROUTE_PV="20010824"
IPROUTE_DEBIAN_PATCH_PV="11"
IPROUTE_P="${IPROUTE_PN}-${IPROUTE_PV}"
IPROUTE_DEBIAN_PATCH="${IPROUTE_P/-/_}-${IPROUTE_DEBIAN_PATCH_PV}.diff.gz"
IPROUTE_SRCFILE="iproute2-2.4.7-now-ss${IPROUTE_PV/20}.tar.gz"

# we also need a vanilla kernel source to use with this
KERNEL_PN=linux
KERNEL_PV=2.4.23
KERNEL_P=${KERNEL_PN}-${KERNEL_PV}

# note this project does NOT use the SF mirroring system
SRC_URI="http://tcng.sourceforge.net/dist/${P}.tar.gz
	tcsim? ( ftp://ftp.inr.ac.ru/ip-routing/${IPROUTE_SRCFILE}
	http://ftp.debian.org/debian/pool/main/i/iproute/${IPROUTE_DEBIAN_PATCH}
	mirror://kernel/linux/kernel/v2.4/${KERNEL_P}.tar.bz2 )"

S=${WORKDIR}/tcng
IPROUTE_S=${WORKDIR}/${IPROUTE_P}
KERNEL_S=${WORKDIR}/${KERNEL_P}

src_unpack() {
	# unpack tcng
	unpack ${P}.tar.gz || die "failed to unpack tcng"
	epatch ${FILESDIR}/${P}-fixes.patch
	epatch ${FILESDIR}/${P}-gentoo.patch

	if use tcsim; then
		# unpack kernel
		unpack ${KERNEL_P}.tar.bz2 || die "failed to unpack kernel"
		ln -s ${KERNEL_S} ${S}/tcsim/linux || die "failed to unpack kernel"

		# unpack iproute
		unpack ${IPROUTE_SRCFILE} || die "failed to unpack iproute"
		mv iproute2 iproute-20010824 || die "failed to unpack iproute"
		epatch ${DISTDIR}/${IPROUTE_DEBIAN_PATCH}
		# this is needed for tcsim
		rm ${IPROUTE_S}/include-glibc/bits/socket.h || die "failed to unpack iproute"
		cp -f ${IPROUTE_S}/include-glibc/socketbits.h ${IPROUTE_S}/include-glibc/bits/socket.h || die "failed to unpack iproute"
		ln -s ${IPROUTE_S} ${S}/tcsim/iproute2 || die "failed to unpack iproute"
	fi
}

src_compile() {
	local myconf
	if use tcsim; then
		myconf="${myconf} --with-tcsim"
		myconf="${myconf} --kernel ${KERNEL_S}"
		myconf="${myconf} --iproute2 ${IPROUTE_S}"
	fi

	# i know this is before install stage, but the build needs it
	dodir /usr/bin

	# configure is NONSTANDARD
	./configure \
		--install-directory /usr \
		--no-manual \
		${myconf} \
		|| die "configure failed"

	# if we aren't debugging, an extra optimization is available
	use debug || CFLAGS="${CFLAGS} -D__NO_STRING_INLINES"
	# upstream package uses CFLAGS var for it's own uses
	sed -i Common.make -e "s/^\(CC_OPTS=\)\(.*\)/\1${CFLAGS} #\2/"
	unset CFLAGS
	emake || die
	cd ${S}/doc
	make tcng.txt
	use doc && make tcng.pdf
}

src_install() {
	dodir /usr
	dodir /usr/bin

	#For localization.sh to work corectly
	#TCNG INSTALL/TOPDIR has to be /usr, instead of /var/tmp/portage/tcng-xx/image/usr...
	sed 's:^\(INSTALL_DIR=\)\(.*\):\1$(DESTDIR)\2:g' -i ${S}/Makefile
	einstall DESTDIR=${D} TCNG_INSTALL_CWD=/usr install-tcc || die "make install-tcc failed"
	if use tcsim; then
		einstall DESTDIR=${D} TCNG_INSTALL_CWD=/usr install-tcsim || die "make install-tcsim failed"
	fi

	# lots of doc stuff
	dodoc CHANGES COPYING.GPL COPYING.LGPL README TODO VERSION tcc/PARAMETERS
	dodoc doc/tcng.txt doc/README.tccext
	newdoc doc/README README.doc
	if use doc; then
		dodoc doc/tcng.ps doc/tcng.pdf
	fi
	if use tcsim; then
		newdoc tcsim/BUGS BUGS.tcsim
		newdoc tcsim/README README.tcsim
	fi
}
