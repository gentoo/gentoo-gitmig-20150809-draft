# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.90.0.1.1-r1.ebuild,v 1.10 2004/10/20 17:30:41 vapier Exp $

inherit eutils libtool flag-o-matic

PATCHVER="1.1"
DESCRIPTION="Tools necessary to build programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2
	mirror://gentoo/${PN}-2.15.90.0.1-patches-${PATCHVER}.tar.bz2"

LICENSE="GPL-2 | LGPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~hppa ~x86"
IUSE="nls bootstrap build multitarget"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	!build? ( !bootstrap? ( dev-lang/perl ) )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# The prescott patch is not ready yet.
	mkdir ${WORKDIR}/patch/skip
	mv ${WORKDIR}/patch/05* ${WORKDIR}/patch/skip/

	EPATCH_SUFFIX=patch epatch ${FILESDIR}/2.15
	epatch ${WORKDIR}/patch

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
	# Generate borked binaries.  Bug #6730
	filter-flags -fomit-frame-pointer -fssa -freduce-all-givs

	local myconf=
	[ ! -z "${CBUILD}" ] && myconf="--build=${CBUILD}"
	use nls \
		&& myconf="${myconf} --without-included-gettext" \
		|| myconf="${myconf} --disable-nls"
	use multitarget && myconf="${myconf} --enable-targets=all"

	# Filter CFLAGS=".. -O2 .." on arm
	use arm && replace-flags -O? -O

	# GCC 3.4 miscompiles binutils unless CFLAGS are conservative. See
	# bug #47581 for more information.
	# Travis Tilley <lv@gentoo.org>
	has_version "=sys-devel/gcc-3.4*" && strip-flags && replace-flags -O3 -O2


	# Fix /usr/lib/libbfd.la
	elibtoolize --portage

	./configure \
		--enable-shared \
		--enable-64-bit-bfd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} \
		|| die

	make configure-bfd || die
	make headers -C bfd || die
	emake tooldir="${ROOT}/usr/bin" all || die

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
		dodoc gprof/ChangeLog* gprof/TEST gprof/TODO gprof/bbconv.pl
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
