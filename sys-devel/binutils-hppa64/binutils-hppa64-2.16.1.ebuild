# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-hppa64/binutils-hppa64-2.16.1.ebuild,v 1.2 2006/01/16 18:29:58 gmsoft Exp $

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

pkg_setup() {
	# glibc or uclibc?
	if use elibc_glibc; then
		MYUSERLAND="gnu"
	elif use elibc_uclibc; then
		MYUSERLAND="uclibc"
	fi

	MYARCH=hppa64
	MYTARGET=${MYARCH}-unknown-linux-${MYUSERLAND}
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
		--target=${MYTARGET} \
		${myconf} || die

	make configure-bfd || die
	make headers -C bfd || die
	emake tooldir="${ROOT}/usr/bin" \
		MAKEOVERRIDES="VERSION=${PV}-${MYARCH}" \
		all || die

}

src_install() {

	make MAKEOVERRIDES="VERSION=${PV}-${MYARCH}" \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# Move shared libs to the standart path
	mv ${D}/usr/${CHOST}/${MYTARGET}/lib/lib*-*.so ${D}/usr/lib

	# Remove unused files
	for i in man info include share ${CHOST} lib/libiberty.a lib/ldscripts
	do
		rm -Rf ${D}/usr/${i}
	done

	# Remove /usr/bin/* to create symlinks
	rm ${D}/usr/bin/*

	# Create symlinks
	cd ${D}/usr/bin
	for i in ${D}/usr/${MYTARGET}/bin/*
	do
		BIN=`basename ${i}`
		dosym ../${MYTARGET}/bin/${BIN} /usr/bin/${MYTARGET}-${BIN}
		dosym ../${MYTARGET}/bin/${BIN} /usr/bin/${MYARCH}-${BIN}

		# The hppa kernel needs that one
		dosym ../${MYTARGET}/bin/${BIN} /usr/bin/${MYARCH}-linux-${BIN}
	done
}
