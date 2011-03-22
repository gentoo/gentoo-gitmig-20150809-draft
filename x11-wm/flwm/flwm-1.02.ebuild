# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.02.ebuild,v 1.3 2011/03/22 10:01:31 jlec Exp $

EAPI=1

inherit savedconfig eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="A lightweight window manager based on fltk"
HOMEPAGE="http://flwm.sourceforge.net/"
SRC_URI="http://flwm.sourceforge.net/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

DEPEND="
	>=x11-libs/fltk-1.1.10-r2:1
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-strip.patch"

	restore_config config.h
	tc-export CXX
}

src_compile() {
	use opengl && export X_EXTRA_LIBS=-lGL
	append-flags -I$(fltk-config --includedir)
	append-ldflags -L$(dirname $(fltk-config --libs))

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	doman flwm.1 || die
	dodoc README flwm_wmconfig || die
	dobin flwm || die

	save_config config.h
}
