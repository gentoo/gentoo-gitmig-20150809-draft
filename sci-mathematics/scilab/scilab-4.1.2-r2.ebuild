# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/scilab/scilab-4.1.2-r2.ebuild,v 1.12 2011/08/02 05:49:16 mattst88 Exp $

EAPI=4

inherit autotools eutils fortran-2 java-pkg-opt-2 multilib toolchain-funcs

DESCRIPTION="Scientific software package for numerical computations (Matlab lookalike)"
LICENSE="scilab"
SRC_URI="http://www.scilab.org/download/${PV}/${P}-src.tar.gz"
HOMEPAGE="http://www.scilab.org/"

SLOT="0"
IUSE="examples gtk java ocaml Xaw3d"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	virtual/fortran
	virtual/blas
	virtual/lapack
	virtual/cblas
	sys-libs/ncurses
	gtk? (
		virtual/jpeg
		media-libs/libpng
		sys-libs/zlib
		x11-libs/gtk+:2
		x11-libs/vte:0
		gnome-extra/gtkhtml:2
	)
	>=dev-lang/tk-8.4
	>=dev-lang/tcl-8.4
	Xaw3d? ( x11-libs/libXaw3d )
	ocaml? ( dev-lang/ocaml )
	java? ( >=virtual/jdk-1.4 )"

DEPEND="${RDEPEND}
	app-text/sablotron"

pkg_setup() {
	fortran-2_pkg_setup
	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-4.0-makefile.patch \
		"${FILESDIR}"/${PN}-4.1-java-pic.patch \
		"${FILESDIR}"/${P}-header-fix.patch \
		"${FILESDIR}"/${PN}-4.1-examples.patch \
		"${FILESDIR}"/${P}-java-config.patch \
		"${FILESDIR}"/${P}-tmp-fix.patch \
		"${FILESDIR}"/${P}-gcc45.patch
	eautoconf

	sed \
		-e "/^ATLAS_LAPACKBLAS\>/s,=.*,= $(pkg-config --libs blas cblas lapack)," \
		-e 's,$(SCIDIR)/libs/lapack.a,,' \
		-i Makefile.OBJ.in || die "Failed to fix Makefile.OBJ.in"

	sed \
		-e "s:\$(PREFIX):\${D}\$(PREFIX):g" \
		-e "s:\$(PREFIX)/lib:\$(PREFIX)/$(get_libdir):g" \
		-i Makefile.in || die "Failed to fix Makefile.in"

	sed \
		-e "s|@CC_OPTIONS@|${CFLAGS}|" \
		-e "s|@FC_OPTIONS@|${FFLAGS}|" \
		-e "s|@LD_LDFLAGS@|${LDFLAGS} -lpthread|" \
		-i Makefile.incl.in || die "Failed to fix Makefile.incl.in"

	# fix bad C practices by failure of scilab build system to
	# include proper headers
	sed -e "s:-DNOTMPNAM:-DNOTMPNAM -DSYSVSTR -DHASSTDLIB:" \
		-i pvm3/conf/LINUX.def -i pvm3/conf/LINUX64.def || \
		die "Failed to fix pvm3 conf scripts."

	# fix examples
	local MAKE_TO_FIX="callsci inter* link* m* interface-multi-so/lib interface-general/lib"
	cd examples/
	for name in ${MAKE_TO_FIX}; do
		sed -e "s:gentoo-scidir:/usr/$(get_libdir)/${P}:" \
			-i ${name}/Makefile || die "Failed to fix examples"
	done
}

src_configure() {
	local myopts
	myopts="${myopts} --with-atlas-library=/usr/$(get_libdir)"

	# the tk interface is the default
	myopts="${myopts} --with-tk"

	if [[ $(tc-getFC) =~ gfortran ]]; then
		myopts="${myopts} --with-gfortran"
	fi

	econf \
		$(use_with Xaw3d xaw3d) \
		$(use_with gtk gtk2 ) \
		$(use_with ocaml) \
		$(use_with java ) \
		${myopts}
}

src_compile() {
	env HOME="${S}" emake -j1 all
}

src_install() {
	default

	# some postinstall fixes
	echo "SCIDIR=/usr/$(get_libdir)/${P}" > \
		"${D}/usr/$(get_libdir)/${P}/Path.incl"

	# install docs
	dodoc ACKNOWLEDGEMENTS Readme_Visual.txt

	# install examples
	if use examples; then
		insinto /usr/share/${PN}/
		doins -r examples/
	fi

	# install static libs since they are needed to link some third
	# party apps (see bug #257252)
	insinto /usr/$(get_libdir)/${P}/libs
	doins libs/*.a

	insinto /usr/$(get_libdir)/${P}
	doins Makefile.incl

	exeinto /usr/$(get_libdir)/${P}
	doexe libtool

	insinto /usr/$(get_libdir)/${P}/config
	doins config/Makeso.incl

	# The compile and install process causes the work folder
	# to be registered as the runtime folder in many files.
	# This is corrected here.
	BAD_REF="${WORKDIR}/${P}"
	FIXED_REF="/usr/$(get_libdir)/${P}"
	local BIN_TO_FIX="Blpr BEpsf Blatexpr2 Blatexprs Blatexpr scilab"
	for i in ${BIN_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i \
		"${D}"/usr/$(get_libdir)/${P}/bin/${i} || \
		die "Failed to fix wrapper scripts"
	done
	local MISC_TO_FIX="util/Blatdoc util/Blatdocs"
	for i in ${MISC_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i \
		"${D}"/usr/$(get_libdir)/${P}/${i} || \
		die "Failed to fix Blatdocs"
	done
}

pkg_postinst() {
	einfo "To tell Scilab about your printers, set the environment"
	einfo "variable PRINTERS in the form:"
	einfo
	einfo "PRINTERS=\"firstPrinter:secondPrinter:anotherPrinter\""
}
