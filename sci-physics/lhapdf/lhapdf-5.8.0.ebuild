# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-5.8.0.ebuild,v 1.1 2009/11/16 20:19:32 bicatali Exp $

EAPI=2

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"
SRC_URI="http://www.hepforge.org/archive/lhapdf/${P}.tar.gz
	test? ( http://svn.hepforge.org/${PN}/pdfsets/tags/${PV}/cteq61.LHgrid
	http://svn.hepforge.org/${PN}/pdfsets/tags/${PV}/cteq61.LHpdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cxx doc examples python test"

DEPEND="doc? ( app-doc/doxygen[latex] )
	python? ( dev-lang/swig )"
RDEPEND=""

src_prepare() {
	# do not create extra latex docs
	sed -i \
		-e 's/GENERATE_LATEX.*=YES/GENERATE_LATEX = NO/g' \
		ccwrap/Doxyfile || die
}

src_configure() {
	econf \
		$(use_enable cxx ccwrap) \
		$(use_enable cxx old-ccwrap ) \
		$(use_enable python pyext) \
		$(use_enable doc doxygen)
}

src_test() {
	LHAPATH="${DISTDIR}" emake check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO AUTHORS ChangeLog

	# leftover
	rm -rf "${D}"/usr/share/${PN}/doc || die
	if use doc && use cxx; then
		# default doc install buggy
		insinto /usr/share/doc/${PF}
		doins -r ccwrap/doxy/html || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{f,cc} || die
	fi
}

pkg_postinst() {
	elog "To install data files, you have to run as root:"
	elog "${ROOT}usr/bin/lhapdf-getdata --dest=${ROOT}usr/share/lhapdf --all"
}

pkg_postrm() {
	if [ -d "${ROOT}usr/share/lhapdf" ]; then
		ewarn "The data directory has not been removed, probably because"
		ewarn "you still have installed data files."
	fi
}
