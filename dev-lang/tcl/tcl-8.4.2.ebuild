# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcl/tcl-8.4.2.ebuild,v 1.2 2003/05/09 14:38:20 utx Exp $


S=${WORKDIR}/${PN}${PV}
SRC_URI="ftp://ftp.scriptics.com/pub/tcl/tcl8_4/${PN}${PV}-src.tar.gz"


HOMEPAGE="http://dev.scriptics.com/software/tcltk/"

DESCRIPTION="Tool Command Language"

# gentoolkit is needed only for revdep-rebuild
DEPEND="virtual/glibc
	>=app-admin/gentoolkit-0.1.22"
RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""

# hyper-optimizations untested...
#

src_compile() {

	cd ${S}/unix
	./configure --host=${CHOST} \
				--prefix=/usr \
				--mandir=/usr/share/man \
				|| die
	# threading is not recommended as it breaks some packages 
	#			--enable-threads \
				
	emake CFLAGS="${CFLAGS}" || die

}

src_install() {

	#short version number
	local v1
	v1=${PV%.*}
	
	cd ${S}/unix
	make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install || die
	
	# fix the tclConfig.sh to eliminate refs to the build directory
	sed -e "s,^TCL_BUILD_LIB_SPEC='-L${S}/unix,TCL_BUILD_LIB_SPEC='-L/usr/lib," \
		-e "s,^TCL_SRC_DIR='${S}',TCL_SRC_DIR='/usr/lib/tcl${v1}/include'," \
		-e "s,^TCL_BUILD_STUB_LIB_SPEC='-L${S}/unix,TCL_BUILD_STUB_LIB_SPEC='-L/usr/lib," \
		-e "s,^TCL_BUILD_STUB_LIB_PATH='${S}/unix,TCL_BUILD_STUB_LIB_PATH='/usr/lib," \
		-e "s,^TCL_LIB_FILE='libtcl8.4..TCL_DBGX..so',TCL_LIB_FILE=\"libtcl8.4\$\{TCL_DBGX\}.so\"," \
		${D}/usr/lib/tclConfig.sh > ${D}/usr/lib/tclConfig.sh.new
	mv ${D}/usr/lib/tclConfig.sh.new ${D}/usr/lib/tclConfig.sh
	
	# install private headers
	dodir /usr/lib/tcl${v1}/include/unix
	install -c -m0644 ${S}/unix/*.h ${D}/usr/lib/tcl${v1}/include/unix
	dodir /usr/lib/tcl${v1}/include/generic
	install -c -m0644 ${S}/generic/*.h ${D}/usr/lib/tcl${v1}/include/generic
	rm -f ${D}/usr/lib/tcl${v1}/include/generic/tcl.h
	rm -f ${D}/usr/lib/tcl${v1}/include/generic/tclDecls.h
	rm -f ${D}/usr/lib/tcl${v1}/include/generic/tclPlatDecls.h	

	# install symlink for libraries
	dosym /usr/lib/libtcl${v1}.so /usr/lib/libtcl.so
	dosym /usr/lib/libtclstub${v1}.a /usr/lib/libtclstub.a
	
	ln -sf tclsh${v1} ${D}/usr/bin/tclsh
	
	cd ${S}
	dodoc README changes license.terms

}

pkg_postinst() {
	ewarn
	ewarn "If you're upgrading from tcl-8.3, you must recompile the other"
	ewarn "packages on your system that link with tcl after the upgrade"
	ewarn "completes.  To perform this action, please run revdep-rebuild."
	ewarn "If you have dev-lang/tk and dev-tcltk/tclx installed you should"
	ewarn "upgrade them before this recompilation, too,"
	ewarn
	sleep 5
}
