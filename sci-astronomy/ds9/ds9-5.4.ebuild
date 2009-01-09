# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/ds9/ds9-5.4.ebuild,v 1.3 2009/01/09 22:45:01 josejx Exp $

EAPI=2
inherit eutils

DESCRIPTION="Data visualization application for astronomical FITS images"
HOMEPAGE="http://hea-www.harvard.edu/RD/ds9"
SRC_URI="http://hea-www.harvard.edu/saord/download/${PN}/source/${PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="dev-tcltk/blt
	>=dev-tcltk/tcllib-1.10
	>=dev-tcltk/tclxml-3.1
	dev-tcltk/tkcon
	>=dev-tcltk/tkimg-1.3.1
	dev-tcltk/tktable
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/xpa
	sci-astronomy/ast
	sci-astronomy/funtools"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/sao${PN}"

src_prepare() {
	# some patches are adapted from fedora
	# most of them are to use system libraries instead of bundled-ones
	epatch "${FILESDIR}"/${P}-saotk.patch
	epatch "${FILESDIR}"/${P}-htmlwidget.patch
	epatch "${FILESDIR}"/${P}-main.patch
	epatch "${FILESDIR}"/${P}-src.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch

	# remove build-time dependency on etags (i.e. emacs or xemacs)
	sed -i -e '/^all/s/TAGS//' saotk/*/Makefile || die "sed failed"

	cp "${FILESDIR}"/make.gentoo make.include
	use amd64 && \
		export EXTRA_CPPFLAGS="-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64"
	export OPTS="${CXXFLAGS}"
}

src_install () {
	dobin bin/ds9 || die "failed installing ds9 binary"
	insinto /usr/share/${PN}
	doins -r ds9/zipdir/zvfsmntpt/* || die
	dodoc README acknowledgement || die "failed installing basic doc"
	dosym  ../../${PN}/doc /usr/share/doc/${PF}/html
	doicon doc/sun.gif
	make_desktop_entry ds9 "SAOImage DS9" sun.gif
}
