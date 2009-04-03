# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ginac/ginac-1.5.1.ebuild,v 1.1 2009/04/03 09:44:58 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="C++ library and tools for symbolic calculations"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${P}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND=">=sci-libs/cln-1.2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		   media-gfx/transfig
		   || ( dev-texlive/texlive-fontsrecommended
				app-text/tetex
				app-text/ptex ) )"

src_prepare() {
	# 2 harmless patches from fedora
	epatch "${FILESDIR}"/${P}-lexer_cpp.patch
	epatch "${FILESDIR}"/${P}-pkgconfig.patch
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		# need to run twice to get the references right (you know, latex)
		# do not add die function at the first one
		make pdf
		emake pdf || die "emake pdf failed"
		cd doc/reference
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS || die

	if use doc; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins \
			examples/ginac-examples.pdf \
			reference/reference.pdf \
			tutorial/ginac.pdf \
			|| die "pdf doc install failed"
		dohtml -r reference/html_files/*
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cpp examples/ginac-examples.txt
	fi
}
