# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-5.7.0.ebuild,v 1.1 2009/02/24 13:16:12 bicatali Exp $

EAPI=2
inherit eutils fortran

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"
SRC_URI="http://www.hepforge.org/archive/lhapdf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples python"

DEPEND="doc? ( app-doc/doxygen[latex] )
	python? ( dev-lang/swig )"
RDEPEND=""

FORTRAN="gfortran ifc"

src_prepare() {
	# respect destdir
	sed -i \
		-e 's/$(prefix)/$(DESTDIR)$(prefix)/' \
		pyext/Makefile.in || die
	# do not create extra latex docs
	sed -i \
		-e 's/GENERATE_LATEX.*=YES/GENERATE_LATEX = NO/g' \
		ccwrap/Doxyfile || die
}

src_configure() {
	econf \
		$(use_enable python pyext) \
		$(use_enable doc doxygen)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO AUTHORS ChangeLog

	# leftover
	rm -rf "${D}"/usr/share/${PN}/doc
	if use doc; then
		# default doc install buggy
		insinto /usr/share/doc/${PF}
		doins -r ccwrap/doxy/html || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{f,cc} || die
	fi
}
