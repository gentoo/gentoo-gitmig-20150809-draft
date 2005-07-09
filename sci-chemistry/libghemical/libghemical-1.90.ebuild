# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/libghemical/libghemical-1.90.ebuild,v 1.1 2005/07/09 05:04:40 spyderous Exp $

inherit eutils

DESCRIPTION="Ghemical supports both quantum-mechanics (semi-empirical and ab initio) models and molecular mechanics models (there is an experimental Tripos 5.2-like force field for organic molecules). Also a tool for reduced protein models is included. Geometry optimization, molecular dynamics and a large set of visualization tools are currently available."
HOMEPAGE="http://www.uku.fi/~thassine/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mopac7 mpqc openbabel"

DEPEND="dev-libs/libf2c
	mopac7? ( sci-chemistry/mopac7 )
	openbabel? ( >=sci-chemistry/openbabel-1.100.2 )
	mpqc? ( sci-chemistry/mpqc )
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
