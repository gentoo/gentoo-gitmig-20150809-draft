# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tk/tk-8.4.2-r1.ebuild,v 1.1 2003/05/19 08:38:20 utx Exp $

S=${WORKDIR}/${PN}${PV}
SRC_URI="ftp://ftp.scriptics.com/pub/tcl/tcl8_4/${PN}${PV}-src.tar.gz"
HOMEPAGE="http://dev.scriptics.com/software/tcltk/"
DESCRIPTION="Tk Widget Set"
IUSE=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-apps/portage-2.0.47-r10
	virtual/x11
	=dev-lang/tcl-${PV}*"

src_unpack() {
	unpack ${A}
	cd ${S}/library
	epatch ${FILESDIR}/remove-control-v-8.4.diff
}

# hyper-optimizations untested...
#
src_compile() {
	cd ${S}/unix
	econf \
		--with-tcl=/usr/lib \
		--enable-threads || die
					
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}
	
	cd ${S}/unix
	S= make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install || die
	
	# fix the tkConfig.sh to eliminate refs to the build directory
	sed -i \
		-e "s,^\(TK_BUILD_LIB_SPEC='-L\)${S}/unix,\1/usr/lib," \
		-e "s,^\(TK_SRC_DIR='\)${S}',\1/usr/lib/tk${v1}/include'," \
		-e "s,^\(TK_BUILD_STUB_LIB_SPEC='-L\)${S}/unix,\1/usr/lib," \
		-e "s,^\(TK_BUILD_STUB_LIB_PATH='\)${S}/unix,\1/usr/lib," \
		${D}/usr/lib/tkConfig.sh
	
	# install private headers
	dodir /usr/lib/tk${v1}/include/unix
	install -c -m0644 ${S}/unix/*.h ${D}/usr/lib/tk${v1}/include/unix
	dodir /usr/lib/tk${v1}/include/generic
	install -c -m0644 ${S}/generic/*.h ${D}/usr/lib/tk${v1}/include/generic
	rm -f ${D}/usr/lib/tk${v1}/include/generic/tk.h
	rm -f ${D}/usr/lib/tk${v1}/include/generic/tkDecls.h
	rm -f ${D}/usr/lib/tk${v1}/include/generic/tkPlatDecls.h	

	# install symlink for libraries
	#dosym /usr/lib/libtk${v1}.a /usr/lib/libtk.a
	dosym /usr/lib/libtk${v1}.so /usr/lib/libtk.so
	dosym /usr/lib/libtkstub${v1}.a /usr/lib/libtkstub.a
	
	ln -sf wish${v1} ${D}/usr/bin/wish
	
	cd ${S}
	dodoc README changes license.terms
}
