# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tk/tk-8.4.9.ebuild,v 1.1 2005/03/19 05:53:01 matsuu Exp $

inherit eutils

DESCRIPTION="Tk Widget Set"
HOMEPAGE="http://dev.scriptics.com/software/tcltk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc64 ~sparc ~hppa ~amd64 ~ppc ~mips ~alpha ~arm ~ia64"
IUSE="threads"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-apps/portage-2.0.47-r10
	virtual/x11
	=dev-lang/tcl-${PV}*"

S=${WORKDIR}/${PN}${PV}

pkg_setup() {
	if use threads
	then
		ewarn ""
		ewarn "PLEASE NOTE: You are compiling ${P} with"
		ewarn "threading enabled."
		ewarn "Threading is not supported by all applications"
		ewarn "that compile against tcl. You use threading at"
		ewarn "your own discretion."
		ewarn ""
		epause 5
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/remove-control-v-${PV}.diff || die
	epatch ${FILESDIR}/${P}-man.patch || die
}

src_compile() {
	cd ${S}/unix

	local local_config_use=""

	if use threads
	then
		local_config_use="--enable-threads"
	fi

	econf \
		--with-tcl=/usr/$(get_libdir) \
		${local_config_use} || die

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}

	cd ${S}/unix
	#make INSTALL_ROOT=${D} MAN_INSTALL_DIR=${D}/usr/share/man install || die
	make INSTALL_ROOT=${D} install || die

	# fix the tkConfig.sh to eliminate refs to the build directory
	sed -i \
		-e "s,^\(TK_BUILD_LIB_SPEC='-L\)${S}/unix,\1/usr/$(get_libdir)," \
		-e "s,^\(TK_SRC_DIR='\)${S}',\1/usr/$(get_libdir)/tk${v1}/include'," \
		-e "s,^\(TK_BUILD_STUB_LIB_SPEC='-L\)${S}/unix,\1/usr/$(get_libdir)," \
		-e "s,^\(TK_BUILD_STUB_LIB_PATH='\)${S}/unix,\1/usr/$(get_libdir)," \
		-e "s,^\(TK_CC_SEARCH_FLAGS='.*\)',\1:/usr/$(get_libdir)'," \
		-e "s,^\(TK_LD_SEARCH_FLAGS='.*\)',\1:/usr/$(get_libdir)'," \
		${D}/usr/lib/tkConfig.sh

	# install private headers
	dodir /usr/$(get_libdir)/tk${v1}/include/unix
	install -c -m0644 ${S}/unix/*.h ${D}/usr/$(get_libdir)/tk${v1}/include/unix
	dodir /usr/$(get_libdir)/tk${v1}/include/generic
	install -c -m0644 ${S}/generic/*.h ${D}/usr/$(get_libdir)/tk${v1}/include/generic
	rm -f ${D}/usr/$(get_libdir)/tk${v1}/include/generic/tk.h
	rm -f ${D}/usr/$(get_libdir)/tk${v1}/include/generic/tkDecls.h
	rm -f ${D}/usr/$(get_libdir)/tk${v1}/include/generic/tkPlatDecls.h

	# install symlink for libraries
	#dosym /usr/$(get_libdir)/libtk${v1}.a /usr/$(get_libdir)/libtk.a
	dosym /usr/$(get_libdir)/libtk${v1}.so /usr/$(get_libdir)/libtk.so
	dosym /usr/$(get_libdir)/libtkstub${v1}.a /usr/$(get_libdir)/libtkstub.a

	ln -sf wish${v1} ${D}/usr/bin/wish

	cd ${S}
	dodoc README changes license.terms
}
