# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-5.7.1.ebuild,v 1.1 2009/07/24 23:08:26 bicatali Exp $

EAPI=2
inherit check-reqs

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"

# data built with svn export http://svn.hepforge.org/${PN}/pdfsets/tags/${PV}
SRC_URI="http://www.hepforge.org/archive/lhapdf/${P}.tar.gz
	http://svn.hepforge.org/${PN}/pdfsets/tags/${PV}/cteq61.LHgrid
	http://svn.hepforge.org/${PN}/pdfsets/tags/${PV}/cteq61.LHpdf
	data? ( mirror://gentoo/${P}-pdf.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cxx -data doc examples python test"

DEPEND="doc? ( app-doc/doxygen[latex] )
	python? ( dev-lang/swig )"
RDEPEND=""

pkg_setup() {
	if use data; then
	# Check if we have enough free diskspace to install
		CHECKREQS_DISK_BUILD="1800"
		check_reqs
	fi
}

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

	if use data; then
		elog "Installing data files"
		insinto /usr/share/lhapdf/PDFSets
		doins "${S}-pdf"/* || die
	fi

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
