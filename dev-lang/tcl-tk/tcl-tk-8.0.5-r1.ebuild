# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcl-tk/tcl-tk-8.0.5-r1.ebuild,v 1.1 2000/12/11 17:52:00 achim Exp $
#

P=tcl-tk-8.0.5

R1=tcl8.0.5
A1=${R1}.tar.gz
S1=${WORKDIR}/${R1}
SRC_URI1="ftp://ftp.scriptics.com/pub/tcl/tcl8_0/tcl8.0.5.tar.gz"

R2=tk8.0.5
A2=${R2}.tar.gz
S2=${WORKDIR}/${R2}

SRC_URI2="ftp://ftp.scriptics.com/pub/tcl/tcl8_0/tk8.0.5.tar.gz"

A="${A1} ${A2}"
SRC_URI="${SRC_URI1} ${SRC_URI2}"
HOMEPAGE="http:/dev.scriptics.com/software/tcltk/"

DESCRIPTION="Tool Command Language"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

# hyper-optimizations untested...
#
src_unpack() {
	unpack ${A1}
        unpack ${A2}
	cp ${S1}/unix/configure ${S1}/unix/configure.orig
	sed -e "s/^CFLAGS_OPTIMIZE=-O$/CFLAGS_OPTIMIZE=\$CFLAGS/" \
	       ${S1}/unix/configure.orig > ${S1}/unix/configure 
}

src_compile() {
	cd ${S1}/unix
	try ./configure --host=${CHOST} --prefix=/usr --enable-shared
	try make
	cd ${S2}/unix
	try ./configure --host=${CHOST} --prefix=/usr --with-tcl=${S1}/unix --enable-shared
	try make
}

src_install() {
	cd ${S1}/unix
	try make INSTALL_ROOT=${D} install
	cd ${S2}/unix
	try make INSTALL_ROOT=${D} install
	strip ${D}/usr/bin/*
#	ln -sf wish8.1 ${D}/usr/bin/wish
#	ln -sf tclsh8.1 ${D}/usr/bin/tclsh
	cd ${S1}
	dodoc README changes license.terms

	prepman
}



