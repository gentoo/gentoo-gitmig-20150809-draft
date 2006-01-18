# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libghemical/libghemical-1.91.ebuild,v 1.2 2006/01/18 11:08:58 spyderous Exp $

inherit eutils

DESCRIPTION="Ghemical supports both quantum-mechanics (semi-empirical and ab initio) models and molecular mechanics models (there is an experimental Tripos 5.2-like force field for organic molecules). Also a tool for reduced protein models is included. Geometry optimization, molecular dynamics and a large set of visualization tools are currently available."
HOMEPAGE="http://www.uku.fi/~thassine/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="mopac7 mpqc openbabel"

RDEPEND="virtual/glut
	mopac7? ( sci-chemistry/mopac7 )
	openbabel? ( =sci-chemistry/openbabel-1.100.2 )
	mpqc? ( <sci-chemistry/mpqc-2.3.0 )
	virtual/blas
	virtual/lapack"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15"

src_compile() {
	libtoolize --copy --force

	./configure \
		--prefix=/usr \
		$(use_enable mopac7) \
		$(use_enable mpqc) \
		$(use_enable openbabel) || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
}
