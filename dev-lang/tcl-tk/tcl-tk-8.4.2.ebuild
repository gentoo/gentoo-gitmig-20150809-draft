# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/dev-lang/tcl-tk/tcl-tk-8.1.1-r1.ebuild,v 1.2 2001/05/01 18:29:05 achim Exp

R1=tcl8.4a2
V1=8.4
A1=${R1}.tar.gz
S1=${WORKDIR}/${R1}
SRC_URI1="ftp://ftp.scriptics.com/pub/tcl/tcl8_4/${A1}"

R2=tk8.4a2
V2=8.4
A2=${R2}.tar.gz
S2=${WORKDIR}/${R2}
SRC_URI2="ftp://ftp.scriptics.com/pub/tcl/tcl8_4/${A2}"

A="${A1} ${A2}"
SRC_URI="${SRC_URI1} ${SRC_URI2}"
HOMEPAGE="http://dev.scriptics.com/software/tcltk/"

DESCRIPTION="Tool Command Language/Tk Widget Set"

DEPEND="virtual/glibc virtual/x11"

# hyper-optimizations untested...
#
src_unpack() {
	unpack ${A1}
        unpack ${A2}
}

src_compile() {
	cd ${S1}/unix
	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --enable-threads
	try make CFLAGS=\""${CFLAGS}"\"
	cd ${S2}/unix
	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --with-tcl=${S1}/unix --enable-threads
	try make CFLAGS=\""${CFLAGS}"\"
}

src_install() {
	cd ${S1}/unix
	try make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install
	
	# fix the tclConfig.sh to eliminate refs to the build directory
	sed -e "s,^TCL_BUILD_LIB_SPEC='-L${S1}/unix,TCL_BUILD_LIB_SPEC='-L/usr/lib," \
	    -e "s,^TCL_SRC_DIR='${S1}',TCL_SRC_DIR='/usr/lib/tcl${V1}/include'," \
	    -e "s,^TCL_BUILD_STUB_LIB_SPEC='-L${S1}/unix,TCL_BUILD_STUB_LIB_SPEC='-L/usr/lib," \
	    -e "s,^TCL_BUILD_STUB_LIB_PATH='${S1}/unix,TCL_BUILD_STUB_LIB_PATH='/usr/lib," \
	    ${D}/usr/lib/tclConfig.sh > ${D}/usr/lib/tclConfig.sh.new
	mv ${D}/usr/lib/tclConfig.sh.new ${D}/usr/lib/tclConfig.sh
	
	# install private headers
	dodir /usr/lib/tcl${V1}/include/unix
	install -c -m0644 ${S1}/unix/*.h ${D}/usr/lib/tcl${V1}/include/unix
	dodir /usr/lib/tcl${V1}/include/generic
	install -c -m0644 ${S1}/generic/*.h ${D}/usr/lib/tcl${V1}/include/generic
	rm -f ${D}/usr/lib/tcl${V1}/include/generic/tcl.h
	rm -f ${D}/usr/lib/tcl${V1}/include/generic/tclDecls.h
	rm -f ${D}/usr/lib/tcl${V1}/include/generic/tclPlatDecls.h	
	
	cd ${S2}/unix
	try make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install
	
	# fix the tclConfig.sh to eliminate refs to the build directory
	sed -e "s,^TK_BUILD_LIB_SPEC='-L${S2}/unix,TCL_BUILD_LIB_SPEC='-L/usr/lib," \
	    -e "s,^TK_SRC_DIR='${S2}',TCL_SRC_DIR='/usr/lib/tk${V2}/include'," \
	    -e "s,^TK_BUILD_STUB_LIB_SPEC='-L${S2}/unix,TCL_BUILD_STUB_LIB_SPEC='-L/usr/lib," \
	    -e "s,^TK_BUILD_STUB_LIB_PATH='${S2}/unix,TCL_BUILD_STUB_LIB_PATH='/usr/lib," \
	    ${D}/usr/lib/tkConfig.sh > ${D}/usr/lib/tkConfig.sh.new
	mv ${D}/usr/lib/tkConfig.sh.new ${D}/usr/lib/tkConfig.sh
	
	# install private headers
	dodir /usr/lib/tk${V2}/include/unix
	install -c -m0644 ${S1}/unix/*.h ${D}/usr/lib/tk${V2}/include/unix
	dodir /usr/lib/tk${V2}/include/generic
	install -c -m0644 ${S1}/generic/*.h ${D}/usr/lib/tk${V2}/include/generic
	rm -f ${D}/usr/lib/tk${V2}/include/generic/tk.h
	rm -f ${D}/usr/lib/tk${V2}/include/generic/tkDecls.h
	rm -f ${D}/usr/lib/tk${V2}/include/generic/tkPlatDecls.h	
	
	ln -sf tclsh${V1} ${D}/usr/bin/tclsh
	ln -sf wish${V2} ${D}/usr/bin/wish
	
	cd ${S1}
	dodoc README changes license.terms

}
