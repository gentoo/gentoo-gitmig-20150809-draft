# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/scilab/scilab-4.0.ebuild,v 1.1 2006/04/25 14:32:04 markusle Exp $

inherit eutils fortran toolchain-funcs multilib

DESCRIPTION="Scientific software package for numerical computations (Matlab lookalike)"
LICENSE="scilab"
SRC_URI="http://scilabsoft.inria.fr/download/stable/${P}-src.tar.gz"
HOMEPAGE="http://www.scilab.org/"

SLOT="0"
IUSE="ocaml tcltk gtk Xaw3d java"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/blas
	virtual/lapack
	sys-libs/ncurses
	gtk? (
		media-libs/jpeg
		media-libs/libpng
		sys-libs/zlib
		>=x11-libs/gtk+-2
		>=x11-libs/libzvt-2
		x11-libs/vte
		=gnome-extra/gtkhtml-2*
	)
	tcltk? ( >=dev-lang/tk-8.4
		>=dev-lang/tcl-8.4 )
	Xaw3d? ( x11-libs/Xaw3d )
	ocaml? ( dev-lang/ocaml )"

DEPEND="${RDEPEND}
	app-text/sablotron"

pkg_setup() {
	if ! use gtk && ! use tcltk; then
		echo
		eerror 'scilab must be built with either USE="gtk" or USE="tcltk"'
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-makefile.patch

	sed -e '/^ATLAS_LAPACKBLAS\>/s,=.*,= $(ATLASDIR)/liblapack.so $(ATLASDIR)/libblas.so $(ATLASDIR)/libcblas.so,' \
		-e 's,$(SCIDIR)/libs/lapack.a,,' \
		-i Makefile.OBJ.in || die "Failed to fix Makefile.OBJ.in"

	sed -e "s:\$(PREFIX):\${D}/\$(PREFIX):g" \
		-i Makefile.in || die "Failed to fix Makefile.in"

	sed -e "s:@CC_OPTIONS@:${CFLAGS}:" \
		-e "s:@FC_OPTIONS@:${FFLAGS}:" \
		-e "s:@LD_LDFLAGS@:$LDFLAGS}:" \
		-i Makefile.incl.in || die "Failed to fix Makefile.incl.in"
}

src_compile() {
	local myopts
	myopts="${myopts} --with-atlas-library=/usr/$(get_libdir)"

	econf $(use_with tcltk tk) \
		$(use_with Xaw3d xaw3d) \
		$(use_with gtk gtk2 ) \
		$(use_with ocaml) \
		$(use_with java ) \
		${myopts} || die "econf failed"
	env HOME="${S}" emake all || die "emake failed"
}

src_install() {
	DESTDIR="${D}" make install || die "installation failed"

	# some postinstall fixes
	echo "SCIDIR=/usr/$(get_libdir)/${P}" > \
		"${D}/usr/$(get_libdir)/${P}/Path.incl"
	strip "${D}/usr/$(get_libdir)/${P}/bin/scilex"

	# install docs
	dodoc ACKNOWLEDGEMENTS CHANGES README_Unix RELEASE_NOTES \
		Readme_Visual.txt license.txt \
		|| die "failed to install docs"

	# install examples
	insinto /usr/share/${PN}/
	doins -r examples/ || die "failed to install examples"

	# The compile and install process causes the work folder 
	# to be registered as the runtime folder in many files. 
	# This is corrected here.
	BAD_REF="${WORKDIR}/${P}"
	FIXED_REF="/usr/$(get_libdir)/${P}"
	BIN_TO_FIX="Blpr BEpsf Blatexpr2 Blatexprs Blatexpr scilab"
	for i in ${BIN_TO_FIX}; do
		sed -e "s%${BAD_REF}%${FIXED_REF}%" -i \
		"${D}"/usr/$(get_libdir)/${P}/bin/${i} || \
		die "Failed to fix wrapper scripts"
	done
	MAN_TO_FIX="eng fr"
	for i in ${MAN_TO_FIX}; do
		for j in "${D}"/usr/$(get_libdir)/${P}/man/${i}/*.h*; do
			sed -e "s%${BAD_REF}%${FIXED_REF}%" -i ${j} || \
			die "Failed to fix manuals"
		done
	done
	MISC_TO_FIX="util/Blatdoc util/Blatdocs"
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
