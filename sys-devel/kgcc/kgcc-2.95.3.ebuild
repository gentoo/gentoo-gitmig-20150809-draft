# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/kgcc/kgcc-2.95.3.ebuild,v 1.11 2004/10/21 02:28:39 weeve Exp $

IUSE="static"

inherit eutils flag-o-matic

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-core-${PV}.tar.bz2"

S="${WORKDIR}/gcc-${PV}"
LOC="/usr"
DESCRIPTION="Modern GCC C compiler for building kernels on Sparc32 machines"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="-x86 -ppc sparc"

DEPEND="virtual/libc"
RDEPEND="virtual/libc"
DEPEND="${DEPEND}
	>=sys-libs/ncurses-5.2-r2
	>=sys-apps/texinfo-4.2-r4"

src_unpack() {
	unpack gcc-core-${PV}.tar.bz2

	cd ${S}

	libtoolize --copy --force &> ${T}/foo-out

	# This new patch for the atexit problem occured with glibc-2.2.3 should
	# work with glibc-2.2.4.  This closes bug #3987 and #4004.
	#
	# Azarah - 29 Jun 2002
	#
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0476.html
	# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2001/08/0589.html
	#
	#
	# Something to note, is that this patch makes gcc crash if its given
	# the "-mno-ieee-fp" flag ... libvorbis is an good example of this.
	# This however is on of those which one we want fixed most cases :/
	#
	# Azarah - 30 Jun 2002
	#
	epatch ${FILESDIR}/${P}-new-atexit.diff

}

src_compile() {
	local myconf=""
	myconf="${myconf} --enable-languages=c --enable-shared"

	filter-flags -fPIC -fstack-protector

	# gcc does not like optimization

	unset CFLAGS
	unset CXXFLAGS

	${S}/configure --prefix=${LOC} \
		--mandir=${LOC}/share/man \
		--infodir=${LOC}/share/info \
		--enable-version-specific-runtime-libs \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-threads \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	if ! use static
	then
		emake bootstrap-lean || die
	else
		emake LDFLAGS=-static bootstrap || die
	fi
}

src_install() {
	cd ${S}
	make install \
		prefix=${D}${LOC} \
		mandir=${D}${LOC}/share/man \
		infodir=${D}${LOC}/share/info || die

	# binutils libiberty.a and we want to use that version
	# closes bug #2262
	rm -f ${D}/usr/lib/libiberty.a

	# Don't need man and info files
	cd ${D}/usr/share
	rm -rf info man

	cd ${D}/usr/bin
	mv -f gcc kgcc
	rm -rf cpp gcov unprotoize protoize *-gnu-gcc

	cd ${D}/usr
	rm -rf *-linux-gnu

	cd ${S}
	docinto /
	dodoc COPYING COPYING.LIB README* FAQ MAINTAINERS
	docinto html
	dodoc faq.html
	docinto gcc
	cd ${S}/gcc
	dodoc BUGS ChangeLog* COPYING* FSFChangeLog* LANGUAGES NEWS PROBLEMS README* SERVICE TESTS.FLUNK
}

