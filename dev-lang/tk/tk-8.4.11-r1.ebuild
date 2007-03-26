# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tk/tk-8.4.11-r1.ebuild,v 1.3 2007/03/26 07:57:18 antarus Exp $

inherit eutils

DESCRIPTION="Tk Widget Set"
HOMEPAGE="http://dev.scriptics.com/software/tcltk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="threads"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )
	=dev-lang/tcl-${PV}*"
DEPEND="${RDEPEND}
	|| (
		( x11-libs/libXt x11-proto/xproto )
		virtual/x11
	)"

S=${WORKDIR}/${PN}${PV}

pkg_setup() {
	if use threads ; then
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
	cd "${S}"
	epatch "${FILESDIR}"/remove-control-v-8.4.9.diff
	epatch "${FILESDIR}"/${PN}-8.4.9-man.patch
	epatch "${FILESDIR}"/${P}-multilib.patch

	# Bug 117982
	sed -i -e "s/relid'/relid/" "${S}"/unix/{configure,tcl.m4} || die

	local d
	for d in */configure ; do
		cd "${S}"/${d%%/*}
		EPATCH_SINGLE_MSG="Patching nls cruft in ${d}" \
		epatch "${FILESDIR}"/tk-configure-LANG.patch
	done
}

src_compile() {
	cd "${S}"/unix

	local mylibdir=$(get_libdir) ; mylibdir=${mylibdir//\/}
	local local_config_use=""

	if use threads ; then
		local_config_use="--enable-threads"
	fi

	econf \
		--with-tcl=/usr/${mylibdir} \
		${local_config_use} || die

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}

	cd "${S}"/unix
	make DESTDIR=${D} install || die

	# fix the tkConfig.sh to eliminate refs to the build directory
	local mylibdir=$(get_libdir) ; mylibdir=${mylibdir//\/}
	sed -i \
		-e "s,^\(TK_BUILD_LIB_SPEC='-L\)${S}/unix,\1/usr/${mylibdir}," \
		-e "s,^\(TK_SRC_DIR='\)${S}',\1/usr/${mylibdir}/tk${v1}/include'," \
		-e "s,^\(TK_BUILD_STUB_LIB_SPEC='-L\)${S}/unix,\1/usr/${mylibdir}," \
		-e "s,^\(TK_BUILD_STUB_LIB_PATH='\)${S}/unix,\1/usr/${mylibdir}," \
		-e "s,^\(TK_CC_SEARCH_FLAGS='.*\)',\1:/usr/${mylibdir}'," \
		-e "s,^\(TK_LD_SEARCH_FLAGS='.*\)',\1:/usr/${mylibdir}'," \
		${D}/usr/${mylibdir}/tkConfig.sh || die

	# install private headers
	dodir /usr/${mylibdir}/tk${v1}/include/unix
	install -c -m0644 ${S}/unix/*.h ${D}/usr/${mylibdir}/tk${v1}/include/unix
	dodir /usr/${mylibdir}/tk${v1}/include/generic
	install -c -m0644 ${S}/generic/*.h ${D}/usr/${mylibdir}/tk${v1}/include/generic
	rm -f ${D}/usr/${mylibdir}/tk${v1}/include/generic/tk.h
	rm -f ${D}/usr/${mylibdir}/tk${v1}/include/generic/tkDecls.h
	rm -f ${D}/usr/${mylibdir}/tk${v1}/include/generic/tkPlatDecls.h

	# install symlink for libraries
	#dosym /usr/${mylibdir}/libtk${v1}.a /usr/${mylibdir}/libtk.a
	dosym /usr/${mylibdir}/libtk${v1}.so /usr/${mylibdir}/libtk.so
	dosym /usr/${mylibdir}/libtkstub${v1}.a /usr/${mylibdir}/libtkstub.a

	ln -sf wish${v1} ${D}/usr/bin/wish

	cd ${S}
	dodoc ChangeLog README changes license.terms
}
