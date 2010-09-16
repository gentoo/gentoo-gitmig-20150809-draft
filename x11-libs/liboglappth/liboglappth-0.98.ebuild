# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/liboglappth/liboglappth-0.98.ebuild,v 1.6 2010/09/16 17:33:56 scarabeus Exp $

inherit eutils

DESCRIPTION="A library for creating portable OpenGL applications with easy-to-code scene setup and selection."
HOMEPAGE="http://www.bioinformatics.org/ghemical/"
SRC_URI="http://www.bioinformatics.org/ghemical/download/current/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gcc-4.3.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
