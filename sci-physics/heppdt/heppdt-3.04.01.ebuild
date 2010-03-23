# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/heppdt/heppdt-3.04.01.ebuild,v 1.1 2010/03/23 03:24:53 bicatali Exp $

EAPI=2
inherit autotools

MYP=HepPDT-${PV}

DESCRIPTION="Data about each particle from the Review of Particle Properties"
HOMEPAGE="http://lcgapp.cern.ch/project/simu/HepPDT/"
SRC_URI="${HOMEPAGE}/download/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# respect user flags
	sed -i \
		-e '/AC_SUBST(AM_CXXFLAGS)/d' \
		configure.ac || die
	# directories
	sed -i \
		-e 's:$(prefix)/data:$(datadir)/${PN}:g' \
		data/Makefile.am || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog
	use doc && mv "${D}"usr/doc/* "${D}"usr/share/doc/${PF}/
	use examples && mv "${D}"usr/examples "${D}"usr/share/doc/${PF}/
	rm -rf "${D}"usr/{doc,examples}
}
