# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-5.5.0.ebuild,v 1.1 2008/09/07 22:10:27 bicatali Exp $

inherit eutils fortran

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"
SRC_URI="http://www.hepforge.org/archive/lhapdf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples python"

DEPEND="doc? ( app-doc/doxygen )
	python? ( dev-lang/swig )"
RDEPEND=""

pkg_setup() {
	local err
	if use python && ! built_with_use dev-lang/swig python; then
		eerror "You need USE=python in dev-lang/swig for python support."
		err="${err} python"
	fi
	# this is needed for formulas even with html output only
	if use doc && ! built_with_use app-doc/doxygen latex; then
		eerror "You need USE=latex in app-doc/doxygen for docs."
		err="${err} latex"
	fi

	[ -z "${err}" ] || die "Unsatisfied dependencies -- needs manual fix"

	FORTRAN="gfortran ifc"
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# do not create extra latex docs
	sed -i \
		-e 's/GENERATE_LATEX.*=YES/GENERATE_LATEX = NO/g' \
		ccwrap/Doxyfile || die
}

src_compile() {
	econf \
		$(use_enable python pyext) \
		$(use_enable doc doxygen) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO AUTHORS ChangeLog

	use doc && mv "${D}"/usr/share/${PN}/doc/html "${D}"/usr/share/doc/${PF}
	rm -rf "${D}"/usr/share/${PN}/doc
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
