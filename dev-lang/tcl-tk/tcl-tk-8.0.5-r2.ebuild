# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcl-tk/tcl-tk-8.0.5-r2.ebuild,v 1.2 2001/06/01 14:00:14 achim Exp $


R1=tcl${PV}
A1=${R1}.tar.gz
S1=${WORKDIR}/${R1}
SRC_URI1="ftp://ftp.scriptics.com/pub/tcl/tcl8_0/tcl${PV}.tar.gz"

R2=tk${PV}
A2=${R2}.tar.gz
S2=${WORKDIR}/${R2}

SRC_URI2="ftp://ftp.scriptics.com/pub/tcl/tcl8_0/tk${PV}.tar.gz"

A="${A1} ${A2}"
SRC_URI="${SRC_URI1} ${SRC_URI2}"
HOMEPAGE="http:/dev.scriptics.com/software/tcltk/"

DESCRIPTION="Tool Command Language"

DEPEND="virtual/glibc virtual/x11"

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
	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --enable-threads
	try make
	cd ${S2}/unix
	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --with-tcl=${S1}/unix --enable-threads
	try make
}

src_install() {
	cd ${S1}/unix
	try make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install
	cd ${S2}/unix
	try make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install
#	ln -sf wish8.0 ${D}/usr/bin/wish
#	ln -sf tclsh8.0 ${D}/usr/bin/tclsh
	cd ${S1}
	dodoc README changes license.terms

}

