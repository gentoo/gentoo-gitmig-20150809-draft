# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-hppa64/binutils-hppa64-2.14.90.0.8.ebuild,v 1.6 2004/11/08 08:50:31 mr_bones_ Exp $

IUSE="nls bootstrap build"

# NOTE to Maintainer:  ChangeLog states that it no longer use perl to build
#                      the manpages, but seems this is incorrect ....

inherit eutils libtool flag-o-matic

# Generate borked binaries.  Bug #6730
filter-flags "-fomit-frame-pointer -fssa"

MY_P=${P/-hppa64/}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Tools necessary to build programs"
SRC_URI="mirror://kernel/linux/devel/binutils/${MY_P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${MY_P}.tar.bz2"
HOMEPAGE="http://sources.redhat.com/binutils/"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="-* hppa"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	!build? ( !bootstrap? ( dev-lang/perl ) )"

TARGET=hppa64-linux

src_unpack() {

	unpack ${A}

	cd ${S}
	#epatch ${FILESDIR}/hppa64-fptr-reloc.diff

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
	local myconf=

	use nls && \
		myconf="${myconf} --without-included-gettext" || \
		myconf="${myconf} --disable-nls"


	# Fix /usr/lib/libbfd.la
	elibtoolize --portage

	./configure --enable-shared \
		--enable-64-bit-bfd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		--target=${TARGET} \
		${myconf} || die

	make configure-bfd || die
	make headers -C bfd || die
	emake tooldir="${ROOT}/usr/bin" \
		MAKEOVERRIDES="VERSION=${PV}-${TARGET/-linux/}" \
		all || die

}

src_install() {

	make MAKEOVERRIDES="VERSION=${PV}-${TARGET/-linux/}" \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# Move shared libs to the standart path
	mv ${D}/usr/${CHOST}/${TARGET}/lib/lib*-*.so ${D}/usr/lib

	# Remove unused files
	for i in man info include share ${CHOST} lib/libiberty.a lib/ldscripts
	do
		rm -Rf ${D}/usr/${i}
	done

	# Remove /usr/bin/* to create symlinks
	rm ${D}/usr/bin/*

	# Create symlinks
	cd ${D}/usr/bin
	for i in ${D}/usr/${TARGET}/bin/*
	do
		BIN=`basename ${i}`
		dosym ../${TARGET}/bin/${BIN} /usr/bin/${TARGET}-${BIN}
	done
}
