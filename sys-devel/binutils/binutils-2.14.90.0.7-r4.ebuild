# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.14.90.0.7-r4.ebuild,v 1.13 2004/10/30 22:44:03 vapier Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="Tools necessary to build programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ~ppc ppc64 sparc x86"
IUSE="nls bootstrap build"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	!build? ( !bootstrap? ( dev-lang/perl ) )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-glibc21.patch
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.4-sparc-nonpic.patch
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.6-eh-frame-ro-2.patch
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.4-ltconfig-multilib.patch
# Might think of adding the Prescott stuff later on
#	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.4-pni.patch
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.5-s390-pie.patch
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.5-ppc64-pie.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-x86_64-testsuite.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.10-x86_64-gotpcrel.patch
	epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.18-testsuite-Wall-fixes.patch

# This one seems to be partly merged, will need to check later on why
# some bits to bfd/elf-strtab.c was not merged ...
	# This increase c++ linking 2 to 3 times, bug #27540.
#	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.6-merge-speedup.patch

	# Some IA64 patches
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.6-ia64-speedup.patch

	# This fixes a problem with the wrong upcode being used for ppc's
	# long branch stubs:
	#
	#   http://sources.redhat.com/ml/binutils/2003-11/msg00077.html
	#   http://sources.redhat.com/ml/binutils/2003-11/msg00082.html
	#
	# and also fixes dynamic reloc for ppc and a number of other
	# archs.
	#
	#  http://sources.redhat.com/ml/binutils/2003-11/msg00069.html
	#
	use sparc || epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.7-ppc-reloc.patch

	# Teach ld how to ensure that the TLS segment p_vaddr is aligned
	# for a number of archs.
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.7-tls-section-alignment.patch

	# Do not add sections to a PT_GNU_STACK segment, which might be
	# a possible security issue, bug #37033.
	# http://sources.redhat.com/ml/binutils/2003-12/msg00205.html
	epatch ${FILESDIR}/2.14/${PN}-2.14.90.0.7-bfd-pt-gnu-segment-fix.patch

	use amd64 && epatch ${FILESDIR}/${PN}-2.14.amd64-32bit-path-fix.patch
	use x86 && epatch ${FILESDIR}/2.13/${PN}-2.13.90.0.20-array-sects-compat.patch

	# Libtool is broken (Redhat).
	for x in ${S}/opcodes/Makefile.{am,in}
	do
		cp ${x} ${x}.orig
		gawk '
			{
				if ($0 ~ /LIBADD/)
					gsub("../bfd/libbfd.la", "-L../bfd/.libs ../bfd/libbfd.la")

					print
			}' ${x}.orig > ${x}
		rm -rf ${x}.orig
	done
}

src_compile() {
	strip-linguas -i */po #42033

	local myconf=

	use nls && \
		myconf="${myconf} --without-included-gettext" || \
		myconf="${myconf} --disable-nls"

	# Generate borked binaries.  Bug #6730
	filter-flags -fomit-frame-pointer -fssa
	# Filter CFLAGS=".. -O2 .." on arm
	use arm && replace-flags -O? -O
	# GCC 3.4 miscompiles binutils unless CFLAGS are conservative #47581
	has_version "=sys-devel/gcc-3.4*" && strip-flags && replace-flags -O3 -O2

	# Fix /usr/lib/libbfd.la
	elibtoolize --portage

	./configure --enable-shared \
		--enable-64-bit-bfd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	make configure-bfd || die
	make headers -C bfd || die
	emake tooldir="${ROOT}/usr/bin" \
		all || die

	if ! use build
	then
		if ! use bootstrap
		then
			# Nuke the manpages to recreate them (only use this if we have perl)
			find . -name '*.1' -exec rm -f {} \; || :
		fi
		# Make the info pages (makeinfo included with gcc is used)
		make info || die
	fi
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	insinto /usr/include
	doins include/libiberty.h

	# c++filt is included with gcc -- what are these GNU people thinking?
	# but not the manpage, so leave that!
# We install it now, as gcc-3.3 do not have it any longer ...
#	rm -f ${D}/usr/bin/c++filt #${D}/usr/share/man/man1/c++filt*

	# By default strip has a symlink going from /usr/${CHOST}/bin/strip to
	# /usr/bin/strip we should reverse it:

	rm ${D}/usr/${CHOST}/bin/strip; mv ${D}/usr/bin/strip ${D}/usr/${CHOST}/bin/strip
	# The strip symlink gets created in the loop below

	# By default ar, as, ld, nm, ranlib and strip are in two places; create
	# symlinks.  This will reduce the size of the tbz2 significantly.  We also
	# move all the stuff in /usr/bin to /usr/${CHOST}/bin and create the
	# appropriate symlinks.  Things are cleaner that way.
	cd ${D}/usr/bin
	local x=
	for x in * strip
	do
	if [ ! -e ../${CHOST}/bin/${x} ]
		then
			mv ${x} ../${CHOST}/bin/${x}
		else
			rm -f ${x}
		fi
		ln -s ../${CHOST}/bin/${x} ${x}
	done

	if [ -n "${PROFILE_ARCH}" ] && \
	   [ "${PROFILE_ARCH/64}" != "${PROFILE_ARCH}" ]
	then
		dosym ${CHOST} /usr/${CHOST/-/64-}

		for x in `ls ${D}/usr/${CHOST}/bin/`
		do
			[ ! -e "${D}/usr/bin/${CHOST}-${x}" ] && \
				dosym ../${CHOST}/bin/${x} /usr/bin/${CHOST}-${x}
			dosym ../${CHOST}/bin/${x} /usr/bin/${CHOST/-/64-}-${x}
		done
	fi

	cd ${S}
	if ! use build
	then
		make prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install-info || die

		dodoc COPYING* README
		docinto bfd
		dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
		docinto binutils
		dodoc binutils/ChangeLog binutils/NEWS binutils/README
		docinto gas
		dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/NEWS gas/README*
		docinto gprof
		dodoc gprof/ChangeLog* gprof/TEST gprof/TODO
		docinto ld
		dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
		docinto libiberty
		dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README
		docinto opcodes
		dodoc opcodes/ChangeLog*
		# Install pre-generated manpages .. currently we do not ...
	else
		rm -rf ${D}/usr/share/man
	fi
}
